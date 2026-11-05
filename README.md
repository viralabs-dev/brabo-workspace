# brabo-workspace

Pasta-mãe do Brabo: o repositório que reúne, ao lado uns dos outros, os clones dos repositórios `brabo-*` da organização `viralabs-dev`. Este repositório não tem código do produto; ele só sabe onde cada repo mora e como trazê-los.

O Brabo foi separado do monorepo `brabo` em repositórios por camada (ADR 0252). A pasta-mãe é `~/dev/brabo/`, e dentro dela ficam os clones irmãos:

| Repositório | O que é |
|---|---|
| `brabo` | porta de entrada do produto: documentação, `install.sh` e release do produto |
| `brabo-api` | API NestJS (domínio, banco, auth) |
| `brabo-engine` | engine Elixir/OTP (agentes, sessões, filas) |
| `brabo-web` | interface React |
| `brabo-runner` | CLI `brabo-runner` que roda na máquina do usuário |
| `brabo-broker` | único processo com o socket do Docker |
| `brabo-contracts` | contratos compartilhados (`v1.0.0`) |
| `brabo-ci` | workflows reutilizáveis e scripts da política de PR |
| `brabo-infra` | composes (dev, produção, instalação), Kubernetes e o `make dev` que sobe tudo a partir dos clones irmãos |
| `brabo-qa` | testes de ponta a ponta e de propriedades |
| `brabo-old` | o histórico do monorepo, só para consulta |

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

## Licença

MIT, ver `LICENSE`.
