#!/usr/bin/env bash
# Clona os repositórios brabo-* da organização viralabs-dev ao lado deste script.
# Repo que já existe recebe git fetch. Nunca apaga nada. Compatível com bash 3.2.
set -euo pipefail

# Lista ÚNICA dos repositórios. Nova irmã da pasta-mãe entra aqui e só aqui.
REPOS="brabo brabo-api brabo-engine brabo-web brabo-runner brabo-broker brabo-contracts brabo-ci brabo-infra brabo-qa brabo-old"

# BRABO_BASE_URL existe para o teste apontar para repositórios file:// locais.
BASE_URL="${BRABO_BASE_URL:-https://github.com/viralabs-dev}"
PASTA="$(cd "$(dirname "$0")" && pwd)"

for repo in $REPOS; do
  destino="$PASTA/$repo"
  if [ -e "$destino/.git" ]; then
    echo "fetch  $repo"
    git -C "$destino" fetch --quiet --all || { echo "brabo-workspace: falhou no fetch de $repo" >&2; exit 1; }
  elif [ -e "$destino" ]; then
    echo "brabo-workspace: $destino existe e não é um clone git; não mexi nele ($repo)" >&2
    exit 1
  else
    echo "clone  $repo"
    git clone --quiet "$BASE_URL/$repo.git" "$destino" || { echo "brabo-workspace: falhou no clone de $repo" >&2; exit 1; }
  fi
done

echo "pronto: $(echo "$REPOS" | wc -w | tr -d ' ') repositórios em $PASTA"
