#!/usr/bin/env bash
# Roda clonar-tudo.sh contra repositórios file:// falsos numa pasta temporária.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
T="$(mktemp -d)"
trap 'rm -rf "$T"' EXIT
export GIT_AUTHOR_NAME=teste GIT_AUTHOR_EMAIL=teste@teste GIT_COMMITTER_NAME=teste GIT_COMMITTER_EMAIL=teste@teste

# A lista de repos vem do próprio script: uma fonte só.
REPOS="$(sed -n 's/^REPOS="\(.*\)"$/\1/p' "$ROOT/clonar-tudo.sh")"
falhas=0
ok() { echo "ok - $1"; }
nok() { echo "FALHOU - $1" >&2; falhas=$((falhas + 1)); }

# Remotos falsos: um bare por repo, com uma commit em main.
semente="$T/semente"
git init -q "$semente"
echo semente > "$semente/README.md"
git -C "$semente" add README.md
git -C "$semente" commit -q -m "semente"
for r in $REPOS; do
  git init -q --bare "$T/remotes/$r.git"
  git --git-dir="$T/remotes/$r.git" symbolic-ref HEAD refs/heads/main
  git -C "$semente" push -q "$T/remotes/$r.git" HEAD:refs/heads/main
done

# Cada pasta de teste é uma cópia do script (a pasta é a do script).
nova_pasta() { mkdir -p "$1"; cp "$ROOT/clonar-tudo.sh" "$1/"; }
roda() { BRABO_BASE_URL="file://$T/remotes" bash "$1/clonar-tudo.sh"; }

# 1. Caminho feliz: pasta vazia recebe todos os clones.
nova_pasta "$T/p1"
st=0; roda "$T/p1" >"$T/log1" 2>&1 || st=$?
if [ "$st" -eq 0 ]; then ok "clona tudo numa pasta vazia"; else nok "clona tudo (saiu $st)"; cat "$T/log1" >&2; fi
todos=1
for r in $REPOS; do [ -e "$T/p1/$r/.git" ] || todos=0; done
if [ "$todos" -eq 1 ]; then ok "todo repo da lista virou clone"; else nok "faltou clone de algum repo da lista"; fi

# 2. Rodar de novo faz fetch e não apaga nada.
echo marca > "$T/p1/brabo-api/MARCA"
st=0; roda "$T/p1" >"$T/log2" 2>&1 || st=$?
if [ "$st" -eq 0 ] && [ -f "$T/p1/brabo-api/MARCA" ]; then ok "segunda rodada faz fetch e preserva o arquivo local"; else nok "segunda rodada (saiu $st) ou apagou arquivo"; fi

# 3. Falha de rede nomeia o repositório que falhou.
nova_pasta "$T/p3"
mv "$T/remotes/brabo-qa.git" "$T/remotes-off-brabo-qa.git"
st=0; roda "$T/p3" >"$T/log3" 2>&1 || st=$?
mv "$T/remotes-off-brabo-qa.git" "$T/remotes/brabo-qa.git"
if [ "$st" -ne 0 ] && grep -q "brabo-qa" "$T/log3"; then ok "falha de clone nomeia o repo"; else nok "falha de clone não nomeou brabo-qa (saiu $st)"; fi

# 4. Pasta existente que não é clone não é tocada e a falha é nomeada.
nova_pasta "$T/p4"
mkdir "$T/p4/brabo-api"
echo lixo > "$T/p4/brabo-api/arquivo"
st=0; roda "$T/p4" >"$T/log4" 2>&1 || st=$?
if [ "$st" -ne 0 ] && grep -q "brabo-api" "$T/log4" && [ -f "$T/p4/brabo-api/arquivo" ]; then ok "pasta que não é clone: falha nomeada e nada apagado"; else nok "pasta que não é clone foi mexida ou a falha não foi nomeada"; fi

echo "falhas: $falhas"
[ "$falhas" -eq 0 ]
