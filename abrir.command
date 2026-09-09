#!/bin/bash
# Abre a landing page do jeito certo.
# Dê dois cliques neste arquivo em vez de abrir o index.html.
#
# Ele liga um servidorzinho local na sua própria máquina. Isso importa:
# aberto assim, a página se comporta exatamente como vai se comportar
# publicada. Aberto por duplo clique no index.html, o navegador trata
# tudo como arquivo solto e algumas coisas se perdem no caminho.

cd "$(dirname "$0")" || exit 1

if ! curl -s -o /dev/null "http://127.0.0.1:8790/index.html"; then
  python3 -m http.server 8790 >/dev/null 2>&1 &
  sleep 1
fi

open "http://127.0.0.1:8790/index.html"

echo ""
echo "  Página aberta no navegador."
echo ""
echo "  Editou o configuracao.js? Salve e atualize a página (Cmd+R)."
echo "  Para desligar o servidor, feche esta janela do Terminal."
echo ""
