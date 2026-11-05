# Changelog

## Unreleased

- `tag.yml` carimba as tags pelo `brabo-ci` (1ª = `v1.0.0`).
- CI: job `actionlint`.

## 1.0.0 - 2026-11-05

Primeira versão. A pasta-mãe `~/dev/brabo/` passa a ter repositório próprio, criado do zero (não é extração de histórico): `README.md`, `CLAUDE.md` curto, `clonar-tudo.sh` (clona ou atualiza os `brabo-*` da organização `viralabs-dev`, sem apagar nada) com teste em `test/clonar-tudo.test.sh`, e CI com o `shellcheck` do script e o teste, com `uses:` presos a SHA e o binário do `shellcheck` preso por sha256.

Origem: EP-033, AT-711 (ADR 0252).
