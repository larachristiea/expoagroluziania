/* ═══════════════════════════════════════════════════════════════
   CONFIGURAÇÃO E TEXTOS DA PÁGINA

   Este é o ÚNICO arquivo que você precisa mexer.
   Edite o que está entre aspas, salve, e atualize a página.

   Regras:
   • Só mude o que está entre 'aspas simples'
   • Não apague as vírgulas do fim das linhas
   • O que está entre {chaves} é preenchido sozinho — mantenha
   • Se algo quebrar, a página volta aos textos originais sozinha
   ═══════════════════════════════════════════════════════════════ */

window.SITE = {

  /* ── AJUSTES ───────────────────────────────────────────────── */

  empresa:      'LINK EXPLORER',
  evento:       'EXPOAGRO LUZIÂNIA 2026',
  whatsapp:     '556136226666',    // (61) 3622-6666  =  55 + 61 + 36226666
  totalVagas:   100,

  /* ── TELA 1 · CAPA ─────────────────────────────────────────── */

  /* Frase que apresenta a empresa, logo abaixo da marca.
     Deixe vazia ('') para não aparecer. */
  frasePosicionamento: 'O agro não para. Sua internet também não.',

  tituloLinha1: '3 MESES DE INTERNET',
  tituloLinha2: 'por nossa conta.',        // esta linha sai na cor da marca
  subtitulo:    'Para os {vagas} primeiros cadastrados.',
  botaoCapa:    'Garanta a sua',
  seloGrupo:    'Grupo',                   // palavrinha antes do logo da AGE

  textoLegal:   'Para os {vagas} primeiros cadastros. R$ 99,90/mês (800 Mbps) nos 3 primeiros ' +
                'meses, depois R$ 129,90/mês. Fidelidade 12 meses. Sujeito a viabilidade ' +
                'técnica e regulamento.',

  /* ── TELA 2 · FORMULÁRIO ───────────────────────────────────── */

  formTitulo1:  'Falta só',
  formTitulo2:  'o seu contato.',          // esta parte sai na cor da marca
  formApoio:    'Entraremos em contato para o agendamento',

  rotuloNome:   'Seu nome',
  dicaNome:     'João da Silva',       // texto cinza dentro do campo
  rotuloTel:    'Seu WhatsApp',
  dicaTel:      '(00) 00000-0000',

  /* Texto ao lado da caixa de marcar. {politica} vira o link — mantenha
     as chaves onde você quiser que o link apareça na frase. */
  textoConsentimento: 'Ao se cadastrar, você concorda com nossa {politica}.',
  textoPolitica:      'Política de Privacidade',
  linkPolitica:       '',   // ← COLE AQUI o endereço da política (sem isso, não vira link)
  botaoEnviar:  'Quero Ganhar!',

  /* ── TELA 3 · CONFIRMAÇÃO ───────────────────────────────────
     São três desfechos. O número da posição vem do banco, não é
     chutado aqui — {posicao} vira 89, 170, o que for.

     A) Entrou nas 100 primeiras
     B) Ficou de fora das 100
     C) Sem internet na hora, posição ainda não confirmada
     ──────────────────────────────────────────────────────────── */

  /* A) DENTRO DAS 100 */
  okDentroTitulo: 'PARABÉNS!',            // o número já aparece no selo acima
  okDentroApoio:  'Seus 3 meses estão reservados. Vamos agendar sua instalação?',
  okDentroBotao:  'Agendar no WhatsApp',
  msgDentro:      'Oi! Sou {nome}, sou o {posicao}º cadastro da {evento} ' +
                  'e quero agendar a instalação dos meus 3 meses grátis.',

  /* B) FORA DAS 100 — a fila é real: endereço sem viabilidade
        técnica libera vaga, e ela desce para quem está esperando. */
  okForaTitulo:   'Você entrou na fila',
  okForaApoio:    'As 100 vagas já foram preenchidas, mas você está na fila!\n' +
                  'Vamos conferir a viabilidade no seu endereço?',
  okForaBotao:    'Falar com a Link Explorer',
  msgFora:        'Oi! Sou {nome}, fui o {posicao}º cadastro da {evento}. ' +
                  'Quero conferir a viabilidade no meu endereço e entrar na fila.',

  /* C) SEM CONFIRMAÇÃO AINDA (rede caiu na hora do cadastro) */
  rotuloPosicao:  'sua posição',          // legendinha embaixo do número

  okSemNumTitulo: 'Cadastro recebido',
  okSemNumApoio:  'Seu cadastro está salvo! Entraremos em contato.',
  okSemNumBotao:  'Falar no WhatsApp',
  msgSemNum:      'Oi! Sou {nome}, acabei de me cadastrar na {evento} ' +
                  'e quero saber a minha posição.',

  /* ── AVISOS ────────────────────────────────────────────────── */

  avisoOffline:  'Sem internet agora. Pode cadastrar: guardamos e enviamos sozinho quando a rede voltar.',

  erroNome:  'Digite seu nome',
  erroTel:   'Confira o número: DDD + 9 dígitos',
  erroLgpd:  'Marque a caixa para continuar',

  /* ── ARQUIVOS ──────────────────────────────────────────────── */

  imagem:     'capa.jpg',          // 1º quadro, aparece instantâneo
  video:      'capa-video.mp4',    // vídeo da capa em loop
  logoUrl:    'logo.png',          // Link Explorer, em branco
  logoGrupo:  'logo-age.png',      // selo AGE Fibra no rodapé
  logoEvento: 'logo-evento.png',   // brasão da Expoagro no topo
  logoCanto:  'logo-icone.png',    // "L" da Link Explorer, no canto das 3 telas

  /* ── BANCO DE DADOS ────────────────────────────────────────── */

  supabaseUrl: 'https://aqjiowythuxlhzdpawem.supabase.co',

  /* Esta é a chave PÚBLICA (publishable). Ela pode ficar aqui à vista:
     sozinha ela não lê nada — o banco só aceita as duas funções do
     supabase.sql. NUNCA coloque aqui a chave "secret" nem a
     "service_role": essas ignoram todas as regras de segurança. */
  supabaseKey: 'sb_publishable_F-cP_-2zrT8e3Un6kjownA_xW-yq5DC',
};
