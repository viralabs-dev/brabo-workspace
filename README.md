# brabo-workspace

Pasta-mãe do Brabo: o repositório que reúne, ao lado uns dos outros, os clones dos repositórios `brabo-*` da organização `viralabs-dev`. Este repositório não tem código do produto; ele só sabe onde cada repo mora e como trazê-los.

## Repositórios do Brabo

O Brabo é dividido em repositórios por camada (ADR 0252), e o [brabo](https://github.com/viralabs-dev/brabo) é o centro da documentação (<https://viralabs-dev.github.io/brabo/prd/>). A pasta-mãe é `~/dev/brabo/`, e dentro dela ficam os clones irmãos:

| repo | papel | depende de | é usado por |
|---|---|---|---|
| [brabo](https://github.com/viralabs-dev/brabo) | porta de entrada do produto: documentação, `install.sh` e release do produto | todos | infra, workspace |
| [brabo-api](https://github.com/viralabs-dev/brabo-api) | API NestJS (domínio, banco, auth) | contracts, ci, infra | brabo, infra, qa, web, contracts |
| [brabo-engine](https://github.com/viralabs-dev/brabo-engine) | engine Elixir/OTP (agentes, sessões, filas) | contracts, ci | brabo, infra, qa |
| [brabo-web](https://github.com/viralabs-dev/brabo-web) | interface React | contracts, ci, api | brabo, infra |
| [brabo-runner](https://github.com/viralabs-dev/brabo-runner) | CLI `brabo-runner` que roda na máquina do usuário | contracts, ci | brabo, infra |
| [brabo-broker](https://github.com/viralabs-dev/brabo-broker) | único processo com o socket do Docker | contracts, ci | brabo, infra, qa |
| [brabo-contracts](https://github.com/viralabs-dev/brabo-contracts) | contratos compartilhados (`v1.0.0`) | ci | api, broker, runner, web, engine, infra, brabo |
| [brabo-infra](https://github.com/viralabs-dev/brabo-infra) | composes (dev, produção, instalação), Kubernetes, backup e o `make dev` que sobe tudo a partir dos clones irmãos | ci, api, engine, web, runner, broker, contracts, brabo | brabo, qa, api |
| [brabo-ci](https://github.com/viralabs-dev/brabo-ci) | workflows reutilizáveis e scripts da política de PR | — | todos (pela `politica.yml` e pelos carimbos de tag) |
| [brabo-qa](https://github.com/viralabs-dev/brabo-qa) | testes de ponta a ponta (E2E), golden-sets e de propriedades | ci, api, engine, broker, infra | brabo |
| [brabo-workspace](https://github.com/viralabs-dev/brabo-workspace) | esta pasta-mãe: `clonar-tudo.sh` e o `CLAUDE.md` transversal | ci | — |

O clone local `brabo-old` é o monorepo antigo, arquivado: o remoto `daneiel/brabo` hoje é o [`viralabs-dev/brabo-legacy`](https://github.com/viralabs-dev/brabo-legacy), só para consulta; o `clonar-tudo.sh` o clona de lá na pasta `brabo-old`.

## Como clonar

Requisitos: `git` e `bash`. O acesso é por HTTPS, sem chave SSH.

```bash
git clone https://github.com/viralabs-dev/brabo-workspace.git ~/dev/brabo
cd ~/dev/brabo
./clonar-tudo.sh
```

O `clonar-tudo.sh` clona por HTTPS cada `brabo-*` que ainda não existe na pasta, faz `git fetch` nos que já existem e nunca apaga nada. Se um repositório falhar, ele para e diz o nome. Para acrescentar um repo novo à organização, edite a variável `REPOS` do script, e só lá.

## Como subir o dev

Depois do `./clonar-tudo.sh`, quem sobe o ambiente de dev é o `brabo-infra`, construindo cada serviço a partir dos clones irmãos desta pasta:

```bash
cd brabo-infra
make dev
```

O `make dev` confere que os irmãos estão no lugar e sobe o compose. Para outra pasta-mãe, use `BRABO_IRMAOS` (ver o README do `brabo-infra`).

## Testes

```bash
bash test/clonar-tudo.test.sh
```

O teste roda o script contra repositórios `file://` falsos numa pasta temporária. O CI roda o teste e o `shellcheck` a cada PR e push em `dev` e `main`.

## Regras

Este repositório guarda só as regras da pasta-mãe, em `CLAUDE.md`. O detalhe de cada repo fica no próprio repo (a AT-708 cuida disso).

## Apoie

Se o projeto te ajuda, você pode [pagar um café no Ko-fi](https://ko-fi.com/daneiel).

## Licença

MIT, ver `LICENSE`.
