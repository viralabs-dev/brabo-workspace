# brabo-workspace (pasta-mãe)

Este repositório não tem código do produto. Ele é a pasta `~/dev/brabo/`, onde moram os clones irmãos `brabo-*`. As sessões do Claude abrem aqui (o diretório de memória deriva deste caminho), então este arquivo é lido junto com o `CLAUDE.md` do repo em que se está mexendo.

## Mapa dos 11 repos e onde mora cada regra
| Repo | O que é | `CLAUDE.md` |
|---|---|---|
| `brabo` | porta de entrada: docs agregadas, site (`/dev/`, `/prd/`), `install.sh`, release do produto | `brabo/CLAUDE.md` |
| `brabo-api` | NestJS 11 + Drizzle + PostgreSQL/pgvector: schema, RBAC, LLM, metering, gates, `openapi.json` | `brabo-api/CLAUDE.md` |
| `brabo-engine` | Elixir/OTP + Phoenix + Oban: agentes (Harness), sessões, gates, runner-router | `brabo-engine/CLAUDE.md` |
| `brabo-web` | React 19 + Vite: telas, i18n (pt-BR fonte), design system | `brabo-web/CLAUDE.md` |
| `brabo-runner` | CLI `brabo-runner` na máquina do usuário (PTY, container local, espelho) | `brabo-runner/CLAUDE.md` |
| `brabo-broker` | único processo com o socket do Docker do servidor | `brabo-broker/CLAUDE.md` |
| `brabo-contracts` | `shared`, `docker-port`, `areas.json`, `fluxo.yml`; consumo por TAG | `brabo-contracts/CLAUDE.md` |
| `brabo-ci` | workflows reutilizáveis e a política de PR, escada, promoção, tag, Dependabot | `brabo-ci/CLAUDE.md` |
| `brabo-infra` | composes, Dockerfiles de integração, `deploy/k8s`, `scripts/dev`, release e supply chain | `brabo-infra/CLAUDE.md` |
| `brabo-qa` | E2E de navegador (Playwright), golden-sets, roteiro TP-01 | `brabo-qa/CLAUDE.md` |
| `brabo-workspace` | esta pasta-mãe: `clonar-tudo.sh` e este arquivo | este arquivo |

O histórico do monorepo antigo, arquivado ([`viralabs-dev/brabo-legacy`](https://github.com/viralabs-dev/brabo-legacy), clone local `brabo-old`), é só consulta. O detalhe de regra por repo fica no `CLAUDE.md` de cada um: não copie regra para cá.

## Regras TRANSVERSAIS (valem em todo repo)
- **Gitflow e escada.** Branches permanentes: `dev` e `main` (a esteira é `dev → main`); trabalho nasce de `dev` com a taxonomia `breaking/`, `feature/`, `bugfix/`, `perf/`, `refactor/`, `chore/`, `docs/`, `test/` (`hotfix/` nasce de `main`), formato `funcao/descritivo` (`^.{0,30}/\S{0,32}$`). A FUNÇÃO decide a versão: `breaking/` sobe MAJOR, `feature/` MINOR, o resto PATCH. Toda mudança entra por PR; push direto em permanente é bloqueado. A escada de aprovação e a promoção vêm dos workflows reutilizáveis do `brabo-ci`.
- **Commits** em conventional commits, em pt-BR.
- **Merge na `main` é do dono.** Merge em branch protegida nunca é automatizado. Tag só por workflow, nunca à mão.
- **Teste nunca no Postgres da instalação.** Use Postgres descartável (projeto compose `-p <nome>`); o dev é `brabo-dev` e a instalação é `brabo`, e um não toca o outro.
- **Segredos nunca são impressos** (chave de LLM, token de git, `.env`), nem em log, PR ou relatório.
- **Documentação em pt-BR.** Toda doc de repositório público (README, CONTRIBUTING, arquivos de comunidade, `docs/`, CHANGELOG) é escrita em pt-BR por padrão (decisão do dono de 06/11/2026, revertendo o ADR 0260). O site central é <https://viralabs-dev.github.io/brabo/prd/>.
- **Documentação é parte do pronto.** Cada repo de código tem `docs/` própria, atualizada na mesma mudança, com `CHANGELOG.md` (Unreleased); o `brabo` agrega o site. Contrato entre repos só por TAG do `brabo-contracts`.
- **Contas GitHub.** `daneiel` em todo repo do Brabo; nunca citar outra conta aqui.

## Ao mexer aqui
- `clonar-tudo.sh` é bash 3.2-compatível (macOS). Nada de arrays associativos, `mapfile` ou `${var,,}`.
- Ele nunca apaga nada. Mudança que apague deve ser recusada.
- A lista de repos é a variável `REPOS`, e só ela.
- Toda mudança passa pelo teste `test/clonar-tudo.test.sh` e pelo `shellcheck` do CI.
- Este arquivo também é doc: ao criar, renomear ou aposentar um repo, ajuste o mapa acima no mesmo PR.
