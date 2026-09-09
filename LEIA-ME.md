# LP de captação — evento

Duas telas: capa com o botão, formulário na sequência.

**Para mudar qualquer texto, abra só o `configuracao.js`** — não precisa mexer
em HTML. Instruções na seção 2.

---

## 1. Criar o banco no Supabase

1. supabase.com → **New project** (o plano grátis dá conta de sobra)
2. Menu lateral → **SQL Editor** → **New query**
3. Cole o conteúdo inteiro de `supabase.sql` → **Run**
4. Menu lateral → **Project Settings → API**. Copie:
   - **Project URL** (`https://xxxxx.supabase.co`)
   - **anon public** (a chave longa)

> A chave `service_role` logo abaixo **nunca** vai na página: ela dá acesso
> total ao banco. A `anon` pode ir, porque o SQL configura o banco para que
> ela **insira mas não leia** — sem isso, qualquer um baixaria sua base
> inteira de telefones abrindo o código-fonte da página.

---

## 2. Editar textos e ajustes

**Você só precisa abrir um arquivo: `configuracao.js`.**

Ele tem todo o texto que aparece na tela — títulos, botões, mensagens de erro,
a mensagem que já vai digitada no WhatsApp. Nada disso está escrito dentro do
`index.html`, então você nunca precisa mexer em HTML.

### Como ver a página

Dê **dois cliques no `abrir.command`** — não no `index.html`.

Ele liga um servidorzinho na sua própria máquina e abre o navegador. Aberto
assim, a página se comporta igual a como vai se comportar publicada. Abrindo
o `index.html` direto, o navegador trata os arquivos como soltos e alguns não
se enxergam. Abre uma janela do Terminal junto — pode deixar de lado; fechar
essa janela desliga o servidor.

### Como abrir o arquivo de textos

Clique com o botão direito no `configuracao.js` → **Abrir com** → **TextEdit**
(ou VS Code, se você tiver). É um arquivo de texto comum.

### Como editar

Mude **só o que está entre aspas simples**:

```js
  botaoCapa:    'Garanta a sua',
                 ^^^^^^^^^^^^^ isto você troca
```

Três regras e só:

1. Não apague as aspas
2. Não apague a vírgula do fim da linha
3. O que está entre `{chaves}` é preenchido sozinho — `{vagas}` vira 100,
   `{nome}` vira o primeiro nome da pessoa. Mantenha do jeito que está.

Salve (Cmd+S) e atualize a página no navegador (Cmd+R). Aparece na hora.

### Se você errar

A página **não quebra**. Ela volta sozinha aos textos originais e mostra um
aviso amarelo no topo dizendo o que aconteceu. Esse aviso só aparece enquanto
você edita no seu computador — quem estiver no evento nunca vê.

Quase sempre é uma aspa ou uma vírgula faltando. Compare a linha com as de
cima e de baixo.

### O que ainda falta preencher

No `configuracao.js`:

```js
  whatsapp:     '5500000000000',  // ← 55 + DDD + número, só números
  linkPolitica: '',               // ← endereço da Política de Privacidade
  supabaseUrl:  '',               // ← do painel do Supabase
  supabaseKey:  '',               // ← a chave "anon public"
```

Sobre o `linkPolitica`: enquanto estiver vazio, "Política de Privacidade"
aparece como texto simples, sem link. A frase ao lado da caixa promete um
documento — se ele não estiver acessível, a promessa não se cumpre. Preencha
antes de publicar.

Quando preenchido, o link abre em aba nova e **tocar nele não marca a caixa** —
sem isso, quem fosse ler a política acabaria consentindo sem querer.

### As cores

Essas ficam no `index.html`, no topo do arquivo — saíram da própria marca:

```css
--brand:#033555;       /* azul oficial da Link Explorer */
--accent:#033555;      /* preenchimentos: botões, selo, contador, checkbox */
--accent-ink:#FFFFFF;  /* texto em cima do azul */
--btn:#033555;         /* fundo dos botões */
--btn-ink:#FFFFFF;     /* texto dos botões */
--destaque:#FFFFFF;    /* palavra destacada nos títulos */
```

**Onde o azul entra e onde não entra.** O #033555 é escuro. Como
preenchimento ele é perfeito — botão azul com letra branca dá 12,8:1 de
contraste, muito acima do exigido. Como cor de texto sobre o vídeo escuro ele
seria ilegível: azul-marinho em cima de quase preto não se lê.

Por isso a divisão: **azul preenche** (botões, selo da posição, contador,
caixa de marcar) e **branco escreve** (títulos, palavra destacada). Nenhum
tom inventado no meio do caminho.

### A fonte

A página usa **Poppins**, puxada do Google Fonts. Ela carrega com `display=swap`:
o texto aparece na hora na fonte do sistema e troca para a Poppins quando ela
chega. Se a rede do evento não deixar a fonte carregar, a página continua
legível — nunca fica em branco esperando.

Se você preferir zero dependência externa, dá para colocar os arquivos da
Poppins dentro da pasta e servir daqui. Me mande os `.woff2` que eu troco.

---

## 3. Os arquivos da capa

Já estão prontos na pasta:

| arquivo | o que é | peso |
|---|---|---|
| `capa-video.mp4` | seu vídeo limpo, 540×960 | **1,1 MB** (era 20 MB) |
| `capa.jpg` | o primeiro quadro do vídeo | 91 KB |
| `logo.png` | Link Explorer recolorida para branco | 21 KB |
| `logo-age.png` | selo AGE Fibra | 18 KB |
| `logo-evento.png` | brasão da Expoagro, fundo verde removido | 71 KB |
| `logo-icone.png` | "L" da Link Explorer, em pastilha branca | 18 KB |
| `configuracao.js` | todos os textos e ajustes | 4 KB |
| `abrir.command` | atalho que abre a página do jeito certo | 1 KB |

A logo veio em marinho, que sumiria no fundo escuro — recolori para branco
usando o canal de transparência do próprio arquivo, então o traço é idêntico
ao original.

O "L" circular veio em marinho sobre fundo transparente. Testei dois caminhos
sobre um quadro real do vídeo:

- **vazado** — recolorir o traço para branco. O "L" vira espaço negativo e
  mostra o vídeo por trás. Some num trecho claro da imagem.
- **pastilha** — a logo original dentro de um círculo branco. Fica idêntica
  sobre qualquer parte do vídeo.

Ficou a pastilha. Ela também é o único lugar onde o marinho #033555 aparece
como elemento visível da página, e não só como fundo de espera.

O brasão da Expoagro veio sobre fundo verde (chroma key). Removi o verde por
diferença de canal, com rampa suave nas bordas e correção do vazamento de cor,
então não sobrou franja verde em volta do relevo. Ele entra no topo da capa,
onde antes ficava o texto "EVENTO 2026" — se quiser voltar ao texto, é só
esvaziar `logoEvento`.

O `capa.jpg` é exatamente o **primeiro quadro** do vídeo. Por isso, quando o
vídeo começa a tocar, não existe salto: a imagem parada vira imagem em
movimento sem ninguém perceber a troca.

Para trocar o vídeo depois, me mande o arquivo pesado que eu comprimo — a
máquina não tem ffmpeg, mas dá para fazer com as ferramentas nativas.

### Como a capa se comporta

1. O gradiente da marca pinta **instantâneo**
2. O `capa.jpg` (91 KB) entra em seguida — é o primeiro quadro do vídeo
3. O vídeo entra por cima quando estiver tocável

Se a rede não der conta em **6 segundos**, a página desiste do vídeo e libera
a banda: fica a imagem, que é indistinguível de um vídeo parado. Em modo
econômico de dados ou 2G, nem tenta. Autoplay bloqueado dá no mesmo.

Ou seja: **o vídeo é bônus, nunca requisito.** Ninguém vê tela quebrada.

---

## 4. Publicar

Sem instalar nada: **app.netlify.com/drop** e arraste a pasta inteira.
Sai uma URL na hora. Em **Site settings → Change site name** você troca por
algo curto e digitável, útil se o QR falhar e alguém quiser digitar.

---

## 5. QR code

Marque a origem de cada peça:

- `sua-url.com/?o=cartaz`   → cartazes
- `sua-url.com/?o=camiseta` → QR nas camisetas da equipe
- `sua-url.com/?o=palco`    → telão

Cai na coluna `origem` e no fim do evento você sabe qual peça trouxe lead.

**Impressão:** mínimo 5 cm de lado para leitura a um braço de distância,
10 cm para ler a 2 metros. Fundo claro, margem branca generosa em volta.
Escreva embaixo o que a pessoa ganha — QR sem promessa ninguém escaneia.

---

## A posição de cada pessoa

Ao cadastrar, a pessoa vê **o número dela** — 89º, 170º — e um de três desfechos:

| | |
|---|---|
| **1 a 100** | PARABÉNS! Seus 3 meses estão reservados. Vamos agendar sua instalação? |
| **101 em diante** | Você entrou na fila. Vaga que volta por falta de viabilidade desce para ela. |
| **sem rede na hora** | Cadastro recebido, posição confirmada depois pelo WhatsApp. |

O número **não é calculado no navegador** — é o banco que atribui, com uma trava
que serializa cadastros simultâneos. Se fosse feito na página, duas pessoas
cadastrando no mesmo segundo receberiam o mesmo número. Quem preenche duas
vezes recebe sempre o mesmo número de antes, então ninguém ocupa duas vagas
nem "perde" posição por tentar de novo.

**O WhatsApp não abre sozinho.** A pessoa toca no botão quando quiser, e ele
abre em aba nova — a tela com o número dela continua ali.

### A promessa da fila precisa ser real

O texto do 101º em diante diz que vaga devolvida por falta de viabilidade
técnica desce para a fila. Isso é verdade operacionalmente — parte dos 100
primeiros não vai ter viabilidade no endereço. Mas é uma promessa: quando
abrir vaga, chame quem está na fila, na ordem. O banco guarda a ordem exata.

---

## O que a página faz por baixo

| | |
|---|---|
| **Grava antes de enviar** | Salva no aparelho na hora, só depois tenta a rede. Em show o 4G satura e é aí que a maioria das páginas perde lead. |
| **Reenvia sozinha** | Fila local com retry a cada 20s e quando a rede volta. |
| **Posição atômica** | Uma trava no banco garante que cada número saia uma vez só, mesmo com vários cadastros no mesmo segundo. |
| **Valida o telefone** | DDD real, 11 dígitos, começa com 9, rejeita `11111111111`. Número errado é lead morto. |
| **Não duplica** | Índice único no telefone: a mesma pessoa não ocupa duas vagas, e ao tentar de novo recebe o mesmo número. |
| **Normaliza o nome** | `joao da silva` vira `João da Silva` no banco e na mensagem. |
| **Contador ao vivo** | "Restam 37 vagas", nas duas telas. Some sozinho quando zera. |
| **Consentimento LGPD** | Caixa de marcar obrigatória, com link para a política. O aceite fica gravado com o lead e o horário. |
| **Volta sem sair** | O botão "voltar" do celular volta para a capa em vez de fechar a página. |
| **Fundo à prova de falha** | Gradiente → imagem → vídeo, nessa ordem, cada um cobrindo a falha do anterior. |
| **Zero rede externa** | Nenhuma fonte ou biblioteca de fora. Só os seus arquivos. |

---

## Checklist do dia

- [ ] **Zerar a base antes do evento** (apaga os cadastros de teste e faz a
      numeração voltar a começar do 1º):
      ```sql
      delete from public.leads;
      ```
- [ ] Testar o fluxo inteiro no seu celular, do QR ao WhatsApp
- [ ] Confirmar que o lead apareceu na tabela `leads` no Supabase
- [ ] Testar em **modo avião**: preencher, ligar a rede, ver o lead chegar
- [ ] Conferir a mensagem pré-preenchida chegando no WhatsApp da empresa
- [ ] Alguém de plantão respondendo o WhatsApp durante o evento
- [ ] Regulamento pronto (validade, viabilidade, plano exigido, fidelidade)
- [ ] Powerbank para quem estiver com o cartaz

---

## Depois do evento

O ouro está em quem **preencheu e não mandou mensagem** — são os que você
prometeu ligar. No SQL Editor:

```sql
select row_number() over (order by criado_em) as posicao,
       nome, telefone, criado_em
from public.leads
order by criado_em
limit 100;
```

Fale com eles em até 24h. Lead de evento esfria rápido: no dia seguinte a
pessoa ainda lembra do show, em três dias já não lembra de você.
