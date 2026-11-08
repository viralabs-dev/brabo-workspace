# Changelog

## Unreleased

- Docs (AT-867): a linha de badges logo abaixo do título mostra o CI da `dev` e o da `main`, a versão da `dev` (última tag `-dev`), licença MIT, documentação e Ko-fi, no estilo do `brabo` Sem release publicada, o badge de versão da `main` não entra.

- Docs (AT-848): o bloco do mapa do README é regenerado do `repos.yml` do brabo, que ganha a aresta `brabo → brabo-contracts` e a prova em `{arquivo, trecho}` (`mapa-alinhado` volta a bater).
- CI: repina todos os `uses:` e `ci_ref` do `brabo-ci` em `6390ef5` (`v1.4.0-dev.17`, ci#53), que aceita a prova `{arquivo, trecho}` do `mapa-dos-repos.ts`; o pin antigo dá `throw` no formato novo e o `mapa-alinhado` quebra.
- Docs (AT-849 item 5): `CLAUDE.md` diz "Contrato entre repos só por versão publicada da TAG do `brabo-contracts`", em vez de "só por TAG", para bater com o consumo por versão do pacote.
- Docs: o `README.md` segue o esqueleto de 8 seções do `README.modelo.md` do `brabo-ci` (AT-826): para que existe, onde se encaixa (bloco gerado do `repos.yml` do brabo), como é usado, como desenvolver, o que o CI garante, documentação, como replicar, apoie e licença. O detalhe do monorepo antigo e de como subir o dev desce para `docs/pasta-mae.md`.

- CI: o `readme.yml` chama os reutilizáveis `readme-esqueleto.yml` e `mapa-alinhado.yml` do `brabo-ci` pinados em `54dc896` (`v1.4.0-dev.13`). Os dois são informativos, não obrigatórios.

- CI: o check `Dependências de merge` (AT-787) entra pelo `dependencias.yml`, que chama o reutilizável `dependencias-de-merge.yml` do `brabo-ci` pinado em `c6d9394` (`v1.4.0-dev.10`). A PR declara `Depende-de: viralabs-dev/<repo>#<n>` no corpo e o check fica amarelo (`esperando …`) até cada PR citada estar mergeada. Sem linha `Depende-de` o check fica verde ("Sem dependências declaradas"). Não é exigido por ruleset ainda.

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
