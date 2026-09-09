-- ═══════════════════════════════════════════════════════════════
--  LP de captação em evento — estrutura no Supabase
--  Cole TUDO isto no SQL Editor do Supabase e clique em RUN.
--  Pode rodar de novo sem medo: não duplica nem apaga nada.
-- ═══════════════════════════════════════════════════════════════

-- ── 1. A tabela ────────────────────────────────────────────────
create table if not exists public.leads (
  id            uuid primary key default gen_random_uuid(),
  nome          text        not null,
  telefone      text        not null,          -- só dígitos: 61988877766
  consentimento boolean     not null default false,
  evento        text,
  origem        text,                          -- de qual QR/cartaz veio (?o=...)
  criado_em     timestamptz not null default now(),  -- quando a pessoa preencheu
  recebido_em   timestamptz not null default now()   -- quando chegou no banco
);

alter table public.leads add column if not exists posicao integer;

create unique index if not exists leads_telefone_key on public.leads (telefone);
create unique index if not exists leads_posicao_key  on public.leads (posicao);
create index        if not exists leads_criado_em_idx on public.leads (criado_em);

-- Se você já tinha cadastros antes desta atualização, numera eles
-- por ordem de chegada, sem mexer em quem já tem número.
with faltando as (
  select id, row_number() over (order by recebido_em, criado_em)
         + coalesce((select max(posicao) from public.leads), 0) as n
  from public.leads where posicao is null
)
update public.leads l set posicao = faltando.n
from faltando where l.id = faltando.id;


-- ── 2. Registrar e devolver a posição ──────────────────────────
--  O número NÃO pode ser calculado no navegador: duas pessoas
--  cadastrando ao mesmo tempo receberiam o mesmo. Aqui o banco
--  serializa com uma trava, então cada número sai uma única vez.
create or replace function public.registrar_lead(
  p_nome          text,
  p_telefone      text,
  p_consentimento boolean,
  p_evento        text,
  p_origem        text,
  p_criado_em     timestamptz
) returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pos integer;
begin
  -- Trava até o fim da transação: dois cadastros simultâneos entram em fila.
  perform pg_advisory_xact_lock(hashtext('leads_posicao'));

  -- Já cadastrado? Devolve o MESMO número de antes.
  -- (Quem preenche duas vezes não ocupa duas vagas nem "perde" posição.)
  select posicao into v_pos from leads where telefone = p_telefone;
  if v_pos is not null then
    return v_pos;
  end if;

  select coalesce(max(posicao), 0) + 1 into v_pos from leads;

  insert into leads (nome, telefone, consentimento, evento, origem, criado_em, posicao)
  values (p_nome, p_telefone, p_consentimento, p_evento, p_origem, p_criado_em, v_pos);

  return v_pos;
end;
$$;


-- ── 3. Contador de vagas ───────────────────────────────────────
--  O total NÃO fica cravado aqui: quem manda é o `totalVagas` do
--  configuracao.js. Assim existe um lugar só para mudar o número —
--  se ficasse escrito nos dois, um dia eles discordariam em silêncio.
drop function if exists public.vagas_restantes();

create or replace function public.vagas_restantes(p_total integer default 100)
returns integer
language sql
security definer
set search_path = public
as $$
  select greatest(0, p_total - (select count(*) from public.leads))::int;
$$;


-- ── 4. Segurança (LGPD) ────────────────────────────────────────
--  A chave "anon" fica visível no código da página. Então o público
--  não fala com a tabela: só pode chamar as duas funções acima.
--  Ninguém consegue LER a base, e ninguém consegue inserir lixo
--  fora do formato.
alter table public.leads enable row level security;

drop policy if exists "publico pode cadastrar" on public.leads;
revoke all on public.leads from anon, authenticated;

-- Funções "security definer" nascem executáveis por todo mundo. Fecho e
-- libero só para o anon, que é quem a página usa.
revoke all on function public.registrar_lead(text,text,boolean,text,text,timestamptz) from public;
revoke all on function public.vagas_restantes(integer) from public;

grant execute on function public.registrar_lead(text,text,boolean,text,text,timestamptz) to anon;
grant execute on function public.vagas_restantes(integer) to anon;


-- ── 5. Avisa a API que a estrutura mudou ───────────────────────
--  Sem isto a API pode levar um tempo para enxergar as funções novas
--  e a página recebe "function not found" por alguns segundos.
notify pgrst, 'reload schema';


-- ═══════════════════════════════════════════════════════════════
--  TESTE — rode isto logo depois, para provar que ficou de pé
--  antes do evento. Cole em uma nova query e execute o bloco todo.
-- ═══════════════════════════════════════════════════════════════
/*
  -- 1. cadastra dois de mentira e mostra as posições (deve sair 1 e 2)
  select public.registrar_lead('Teste Um',  '61900000001', true, 'TESTE', 'sql', now()) as posicao_1;
  select public.registrar_lead('Teste Dois','61900000002', true, 'TESTE', 'sql', now()) as posicao_2;

  -- 2. repete o primeiro: tem que devolver 1 de novo, não 3
  select public.registrar_lead('Teste Um',  '61900000001', true, 'TESTE', 'sql', now()) as repetido_devolve_1;

  -- 3. contador
  select public.vagas_restantes(100) as vagas_restantes;   -- deve dar 98

  -- 4. limpa a bagunça
  delete from public.leads where evento = 'TESTE';
  select count(*) as deve_ser_zero from public.leads;
*/


-- ═══════════════════════════════════════════════════════════════
--  CONSULTAS PARA VOCÊ USAR DEPOIS DO EVENTO
--  (rode aqui no SQL Editor — você está logada, então enxerga tudo)
-- ═══════════════════════════════════════════════════════════════

-- Quem garantiu os 3 meses (troque o 100 se mudar o total de vagas):
--   select posicao, nome, telefone, criado_em
--   from public.leads where posicao <= 100 order by posicao;

-- A fila de espera, do 101 em diante:
--   select posicao, nome, telefone, criado_em
--   from public.leads where posicao > 100 order by posicao;

-- Quem preencheu no evento mas demorou a sincronizar (estava sem sinal).
-- Se quiser ser justa com quem ficou sem rede, é por aqui que você vê:
--   select posicao, nome, telefone, criado_em, recebido_em,
--          recebido_em - criado_em as atraso
--   from public.leads
--   where recebido_em - criado_em > interval '2 minutes'
--   order by criado_em;

-- Exportar: rode um select e use o botão "Download CSV" no resultado.
