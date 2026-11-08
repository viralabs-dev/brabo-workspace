# Changelog

## Unreleased

- CI: o `ci.yml` chama o reutilizável `cadeia.yml` do `brabo-ci` (actionlint e pins, `ci_ref` obrigatório, AT-819) e perde o job `actionlint` copiado e o `.github/actionlint.yaml` (idêntico ao do brabo-ci). Repina `politica.yml` e `tag.yml` em `0a9eba8` (`v1.4.0-dev.5`, brabo-ci#39), e os `ci_ref` ganham o comentário de versão que faltava.

- `clonar-tudo.sh`: a entrada `brabo-old` dava 404; `REPOS` aceita `pasta=remoto` e `brabo-old=brabo-legacy` clona o monorepo antigo de `viralabs-dev/brabo-legacy`, com teste (AT-783).

- CI: repina os reutilizáveis do `brabo-ci` em `13f3697` (merge da ci#17, que inclui a ci#16): `ubuntu-26.04`, `client-id` no lugar de `app-id`, rótulo de família criado antes de aplicar, linha `Carimbo:` na tag e helper `vinculos` (AT-772, AT-773).
- CI: todo `runs-on` fixa `ubuntu-26.04` no lugar de `ubuntu-latest`, e o `create-github-app-token` usa `client-id` no lugar do `app-id` obsoleto; os runs saem sem anotação de aviso (AT-772).

- Ko-fi do mantenedor: `.github/FUNDING.yml` (botão Sponsor) e seção Apoie no README (AT-768).

- Docs: o `README.md` volta ao pt-BR, padrão da documentação de repo público (decisão do dono de 06/11/2026, revertendo o ADR 0260), com a tabela "Repositórios do Brabo" (links, "depende de" e "é usado por") e o link do site; o `brabo-old` aparece como monorepo antigo, arquivado (`brabo-legacy`). O `CLAUDE.md` ganha a regra de doc em pt-BR (AT-766).

- `politica.yml` novo: `pr-police` e `escada` do `brabo-ci` pinados por SHA (AT-733); inclui a dispensa da PR do bot (ADR 0255).
- README: "Como subir o dev" aponta para o `make dev` do `brabo-infra`, e a tabela descreve o `brabo` como porta de entrada (AT-734).
- `tag.yml` carimba as tags pelo `brabo-ci` (1ª = `v1.0.0`).
- CI: job `actionlint`.

## 1.0.0 - 2026-11-05

Primeira versão. A pasta-mãe `~/dev/brabo/` passa a ter repositório próprio, criado do zero (não é extração de histórico): `README.md`, `CLAUDE.md` curto, `clonar-tudo.sh` (clona ou atualiza os `brabo-*` da organização `viralabs-dev`, sem apagar nada) com teste em `test/clonar-tudo.test.sh`, e CI com o `shellcheck` do script e o teste, com `uses:` presos a SHA e o binário do `shellcheck` preso por sha256.

Origem: EP-033, AT-711 (ADR 0252).
