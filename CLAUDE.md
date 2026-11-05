# brabo-workspace (pasta-mãe)

Este repositório não tem código do produto. Ele é a pasta `~/dev/brabo/`, onde moram os clones irmãos `brabo-*`.

## Mapa dos repos e onde mora cada regra
- Contratos entre os repos: `brabo-contracts`.
- Workflows reutilizáveis e política de PR, merge e release: `brabo-ci`.
- Código da API, do engine, da web, do runner e do broker: cada um no seu repo.
- Subida do ambiente de dev e manifests: `brabo-infra` (chega na AT-701).
- Testes de ponta a ponta: `brabo-qa`.
- Histórico do monorepo, só consulta: `brabo-old`.

O detalhe de regra por repo fica no `CLAUDE.md` de cada um. Não copie regra para cá.

## Ao mexer aqui
- `clonar-tudo.sh` é bash 3.2-compatível (macOS). Nada de arrays associativos, `mapfile` ou `${var,,}`.
- Ele nunca apaga nada. Mudança que apague deve ser recusada.
- A lista de repos é a variável `REPOS`, e só ela.
- Toda mudança passa pelo teste `test/clonar-tudo.test.sh` e pelo `shellcheck` do CI.
- Commit em conventional commits, em pt-BR. Entra por PR em `dev`.
