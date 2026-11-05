# brabo-workspace

Brabo's parent folder: the repository that gathers, side by side, the clones of the `brabo-*` repositories of the `viralabs-dev` organization. This repository has no product code; it only knows where each repo lives and how to bring them in.

Brabo was split out of the `brabo` monorepo into one repository per layer (ADR 0252). The parent folder is `~/dev/brabo/`, and the sibling clones live inside it:

| Repository | What it is |
|---|---|
| `brabo` | the product's front door: documentation, `install.sh` and the product release |
| `brabo-api` | NestJS API (domain, database, auth) |
| `brabo-engine` | Elixir/OTP engine (agents, sessions, queues) |
| `brabo-web` | React interface |
| `brabo-runner` | `brabo-runner` CLI that runs on the user's machine |
| `brabo-broker` | the only process with the Docker socket |
| `brabo-contracts` | shared contracts (`v1.0.0`) |
| `brabo-ci` | reusable workflows and PR policy scripts |
| `brabo-infra` | composes (dev, production, install), Kubernetes and the `make dev` that brings everything up from the sibling clones |
| `brabo-qa` | end-to-end and property tests |
| `brabo-old` | the monorepo history, for reference only |

## How to clone

Requirements: `git` and `bash`. Access is over HTTPS, with no SSH key.

```bash
git clone https://github.com/viralabs-dev/brabo-workspace.git ~/dev/brabo
cd ~/dev/brabo
./clonar-tudo.sh
```

`clonar-tudo.sh` clones over HTTPS each `brabo-*` that is not yet in the folder, runs `git fetch` on the ones that already exist, and never deletes anything. If a repository fails, it stops and says the name. To add a new repo from the organization, edit the script's `REPOS` variable, and only there.

## How to bring up dev

After `./clonar-tudo.sh`, it is `brabo-infra` that brings up the dev environment, building each service from the sibling clones in this folder:

```bash
cd brabo-infra
make dev
```

`make dev` checks that the siblings are in place and brings up the compose. For another parent folder, use `BRABO_IRMAOS` (see the `brabo-infra` README).

## Tests

```bash
bash test/clonar-tudo.test.sh
```

The test runs the script against fake `file://` repositories in a temporary folder. CI runs the test and `shellcheck` on every PR and on every push to `dev` and `main`.

## Rules

This repository keeps only the parent folder's rules, in `CLAUDE.md`. The detail for each repo lives in the repo itself (AT-708 takes care of that).

## License

MIT, see `LICENSE`.
