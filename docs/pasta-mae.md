# Pasta-mãe: detalhes fora do README

O [README](../README.md) diz para que serve este repositório e como clonar os irmãos. Aqui ficam os detalhes que não cabem nele.

## O monorepo antigo (`brabo-old`)

O clone local `brabo-old` é o monorepo antigo, arquivado: o remoto `daneiel/brabo` hoje é o [`viralabs-dev/brabo-legacy`](https://github.com/viralabs-dev/brabo-legacy), só para consulta. O `clonar-tudo.sh` o clona de lá na pasta `brabo-old`, pela entrada `brabo-old=brabo-legacy` da variável `REPOS`.

## Como subir o dev

Depois do `./clonar-tudo.sh`, quem sobe o ambiente de dev é o `brabo-infra`, construindo cada serviço a partir dos clones irmãos desta pasta:

```bash
cd brabo-infra
make dev
```

O `make dev` confere que os irmãos estão no lugar e sobe o compose. Para outra pasta-mãe, use `BRABO_IRMAOS` (ver o README do `brabo-infra`).

## Regras

As regras da pasta-mãe ficam no [`CLAUDE.md`](../CLAUDE.md). O detalhe de cada repo fica no próprio repo.
