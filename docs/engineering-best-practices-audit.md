# Engineering Best Practices Audit — muffin_man

| | |
|---|---|
| **Audit date** | 2026-09-08 |
| **Auditor** | Claude — gauge-repo skill |
| **Rubric version** | `item-credit-v1` — 2026-09-04 (`references/best-practices.md`) |

No prior audit report found at this path — this is the first `gauge-repo` audit of this repository.

## Repo profile

`muffin_man` is a **published Ruby gem providing a client interface to the Amazon Selling Partner API** — currently at version 2.6.0, MIT-licensed, with `LICENSE.txt`, a `Rakefile`, and a gemspec. It is the most conventionally-engineered repository in this batch: a real open-source-shaped library rather than an internal script.

**Test suite is the standout.** 42 RSpec files under `spec/`, supported by **102 recorded JSON response fixtures** and `webmock` (`webmock/rspec` in `spec_helper.rb`, `webmock ~> 2.1` as a development dependency) — so SP-API interactions are exercised against recorded responses rather than live calls.

**CI actually enforces things.** `.github/workflows/ci.yml` triggers on both `push` and `pull_request` to `master`, runs a matrix across three Ruby versions with `bundler-cache: true`, and executes **`bundle exec rspec` and `bundle exec rubocop`** — the only repository in this batch whose CI runs both a test suite and a linter.

**Documentation:** a README carrying a CI status badge, an explanation of what the gem is, installation instructions, and a link to Amazon's Selling Partner API developer guide. A `CHANGELOG.md` exists — one of only two in three batches of these audits.

**Distribution model:** a gem consumed by other Pattern Ruby applications. **Persistence, UI, deployment:** none — this is a library.

**Team signals:** 35 contributors led by Gavin (78 commits), Jason Wells (40), and Prashant Thorat (38). Last commit is `Onboard muffin-man to Backstage` (2026-07-29).

**AWS footprint:** none — the gem talks to Amazon's SP-API over HTTP, not to AWS infrastructure. Item 49's core manifest applies; the `aws[]` sub-check has nothing to describe.

**GitHub owner:** verified `patterninc/muffin_man` via `gh repo view --json nameWithOwner` (default branch `master`). Pattern's inherited Wiz and Toolsmith controls apply.

## Scorecard

| Metric | Value |
|--------|-------|
| **Critical gates** | **RED** |
| **Adjusted compliance** | **43.9%** |

Two of the nine applicable critical gates are not fully Met, so the safety floor is **RED**. Adjusted compliance is calculated independently:

`(13 Met + 0.5 × 3 Partial) / (49 total - 16 justified N/A) = 14.5 / 33 = 43.9%`

**This is the highest adjusted compliance across all three batches of these audits, and the best critical-gate row** — seven of nine applicable gates Met, with unit tests, integration tests, README, and reproducible builds all clean. The two shortfalls are an absent `AGENTS.md` and CI checks that run but are not required.

### Critical gate detail

| # | Gate | Status |
|---|------|--------|
| 2 | AGENTS.md | **Gap** |
| 6 | README setup & run instructions | **Met** |
| 15 | Branch protection | **Met** |
| 16 | Required CI checks before merge | Partial |
| 19 | Secret scanning | **Met** |
| 20 | SAST gate | **Met** |
| 23 | Unit tests | **Met** |
| 24 | Integration tests | **Met** |
| 40 | Scoped secrets per environment | *Not applicable* |
| 48 | Reproducible builds (lockfiles) | **Met** |

### Status totals

| Status | Items |
|--------|------:|
| Met | 13 |
| Partial | 3 |
| Gap | 17 |
| N/A | 16 |
| **Total** | **49** |

### Per-category breakdown

| Category | Met | Partial | Gap | N/A |
|----------|----:|--------:|----:|----:|
| Documentation & Context | 2 | 0 | 5 | 2 |
| Guardrails & Enforcement | 5 | 2 | 5 | 1 |
| Testing & Feedback Loops | 3 | 0 | 4 | 6 |
| Environment & Tooling | 3 | 1 | 2 | 7 |
| Agent dispatch | 0 | 0 | 1 | 0 |
| **Total** | **13** | **3** | **17** | **16** |

## Documentation & Context

| # | Practice | Status | Evidence | Recommendation / rationale |
|---|----------|--------|----------|----------------------------|
| 1 | Skills / reusable prompt workflows | **Gap** | No `.claude/skills/` or `.cursor/` directory | "Add an SP-API endpoint" is the repeatable task, and the existing pattern — client method plus spec plus recorded cassette — is consistent enough to encode. |
| 2 | AGENTS.md | **Gap** | No `AGENTS.md` or `CLAUDE.md` | **Critical gate**, and the only real documentation gap here. The conventions an agent needs are already visible in the code but unstated: every new endpoint gets a spec and a recorded fixture, `webmock` forbids live HTTP in tests, and CI runs against three Ruby versions. |
| 3 | Architecture decision records | **Gap** | No decision records | Modest priority. The choice worth recording is the recorded-fixture strategy over live integration — it is the practice that makes this suite fast and deterministic, and a future contributor might undo it. |
| 4 | Runbooks | **Gap** | No release procedure documented. `CHANGELOG.md` records *what* changed but nothing states how a version is cut, tagged, or published | For a gem consumed by other Pattern applications, the release runbook is the operational document that matters. |
| 5 | API contract docs (OpenAPI / protobuf) | **Not applicable** | The gem publishes no wire protocol; its interface is a Ruby API, and the SP-API contract it consumes is Amazon's, documented in the developer guide the README links | Profile-backed: in-process library. |
| 6 | README with setup & run instructions | **Met** | States what the gem is (a Ruby interface to the Amazon Selling Partner API), how to install it via Gemfile, links to Amazon's SP-API developer guide for registration, and carries a CI status badge at the top | Complete for a library's audience. |
| 7 | Changelog with migration notes | **Met** | `CHANGELOG.md` is present and maintained alongside a versioned gem (currently 2.6.0) | **One of only two repositories across three batches of these audits to earn this item.** For a gem consumed by other applications, this is the difference between a safe upgrade and a guess. |
| 8 | On-call playbooks | **Not applicable** | A library with no deployed runtime; failures surface inside consuming applications and are handled by those teams' rotations | Profile-backed. |
| 9 | CODEOWNERS | **Gap** | No `CODEOWNERS`, with **35 contributors** on a shared library | Unusual for a gem to have this many contributors, and it is exactly the situation path-based review routing exists for — particularly for the auth and request-signing code. |

## Guardrails & Enforcement

| # | Practice | Status | Evidence | Recommendation / rationale |
|---|----------|--------|----------|----------------------------|
| 10 | Linters | **Met** | `.rubocop.yml` is present and `ci.yml` runs `bundle exec rubocop` on every push and pull request — configured *and* enforced | The only repository in this batch where a linter actually runs in CI. |
| 11 | Formatters | **Met** | RuboCop's layout and style cops provide the formatting standard, enforced through the same CI step as item 10 | Equivalent accepted: in Ruby, RuboCop is conventionally both linter and formatter, and it is gating here. |
| 12 | Type checking | **Gap** | No RBS signatures or Sorbet sigils | For a published library, RBS also serves as machine-readable interface documentation for consumers — worth more here than in an application. |
| 13 | Pre-commit hooks | **Gap** | No `.pre-commit-config.yaml` or Husky configuration | Modest value given CI already runs both checks; it would only shorten the feedback loop. |
| 14 | Commit message conventions | **Gap** | No commitlint configuration and no enforced format | Low priority on its own, though it is what would let `CHANGELOG.md` (item 7) be generated rather than hand-maintained. |
| 15 | Branch protection rules | **Met** | `gh api …/branches/master/protection` returns `required_approving_review_count: 1`, with the organization ruleset `require-pr-review` (source `patterninc`, enforcement active) applying on top | Review is genuinely required before merge. |
| 16 | Required CI checks before merge | **Partial** | The workflow is the best in this batch — `pull_request` and `push` triggers, a three-version Ruby matrix, `bundler-cache: true`, `bundle exec rspec`, and `bundle exec rubocop`. The one shortfall is enforcement: `required_status_checks` is `null`, so a red suite still leaves the pull request mergeable | **Critical gate**, and a one-field fix: register the `ci-build` matrix jobs as required checks. Everything else is already in place. |
| 17 | Dependency allow-lists / deny-lists | **Gap** | No policy governing gem additions | Low priority for a library with a small dependency surface. |
| 18 | License compliance scanning | **Gap** | No automated license checking, though the gem itself correctly declares MIT and ships `LICENSE.txt` | Low priority. |
| 19 | Secret scanning | **Met** | Inherited Pattern Wiz org-wide secret scanning (owner verified as `patterninc`). No credential material is committed — SP-API credentials are supplied by consuming applications at runtime, and the 102 recorded fixtures are responses rather than requests | Met — inherited Pattern Wiz policy. Worth noting that recorded HTTP fixtures are a common place for tokens to leak, and these do not appear to carry any. |
| 20 | SAST / static analysis gates | **Met** | Inherited Pattern Wiz org-wide SAST and blocking policy (owner verified as `patterninc`), plus repo-local RuboCop running on every pull request | Met — inherited policy reinforced by a real local check. |
| 21 | Max complexity limits | **Partial** | `.rubocop.yml` is present and RuboCop's `Metrics` department (method length, ABC size, cyclomatic complexity) is enabled by default unless explicitly disabled — so complexity limits are likely enforced through the CI step in item 10. What cannot be confirmed from the repository layout alone is whether those cops have been switched off in the configuration | Verify the `Metrics` cops are enabled rather than excluded; if they are on, this is Met. |
| 22 | Import boundary enforcement | **Not applicable** | A conventional flat gem layout under `lib/muffin_man/` with no architectural layering for a boundary tool to police | Profile-backed. |

## Testing & Feedback Loops

| # | Practice | Status | Evidence | Recommendation / rationale |
|---|----------|--------|----------|----------------------------|
| 23 | Unit tests | **Met** | 42 RSpec files covering the client surface, with `spec/spec_helper.rb`, a `spec/support/` directory, and `spec/muffin_man/` mirroring `lib/muffin_man/`. Run in CI on every push and pull request across three Ruby versions | **Critical gate: Met.** The most substantial test suite in this batch by a wide margin. |
| 24 | Integration tests | **Met** | `webmock/rspec` intercepts HTTP, and **102 recorded JSON response fixtures** drive the SP-API interaction paths — so request construction, authentication headers, response parsing, and error handling are all exercised end to end against realistic payloads without touching Amazon | **Critical gate: Met.** Equivalent accepted: recorded-response integration is the correct pattern for a third-party API client, and it is what makes this suite both fast and deterministic. |
| 25 | Snapshot / golden-file tests | **Gap** | The 102 fixtures are test *inputs* (recorded upstream responses), not golden files pinning this gem's own output — nothing compares the parsed objects the client returns against a stored expectation | A modest addition: pin the parsed shape for a few representative endpoints so a refactor of the parsing layer cannot silently change what consumers receive. |
| 26 | Contract tests (Pact) | **Not applicable** | Consumer-only integration with Amazon's SP-API, which this repository cannot verify from the provider side; the gem publishes no service contract of its own | Profile-backed. Note the drift risk this leaves is real — see item 34's recommendation on fixture provenance. |
| 27 | End-to-end tests (Playwright) | **Not applicable** | No browser UI — a Ruby library | Profile-backed. |
| 28 | Visual regression tests | **Not applicable** | No visual surface | Profile-backed. |
| 29 | Test coverage thresholds | **Gap** | No SimpleCov and no coverage gate, despite a substantial suite | The one cheap addition that would strengthen an already-good testing story: with 42 spec files, the starting number is likely respectable and worth locking in. |
| 30 | Mutation testing | **Gap** | No mutation tooling | Low priority, but this is the rare repository where base coverage is good enough for mutation testing to be the sensible next step. |
| 31 | Load / performance benchmarks | **Not applicable** | A request-per-call API client with no throughput characteristic of its own; performance belongs to the HTTP layer and to Amazon | Profile-backed. |
| 32 | Flaky test quarantine | **Gap** | No quarantine mechanism | Low priority precisely because the suite is deterministic by design (item 24) — there is little flakiness to quarantine. |
| 33 | Structured CI output | **Gap** | RSpec's default text formatter; no JUnit reporter and no results artifact uploaded | Small: add `--format RspecJunitFormatter` and upload, so a failing matrix job is machine-parseable across three Ruby versions. |
| 34 | Deterministic test fixtures | **Met** | 102 committed JSON response fixtures, loaded through `webmock` so no test performs live HTTP. Nothing depends on network, wall-clock, or ambient credentials | **Best fixture discipline in these audits.** One improvement worth noting: the fixtures carry no recorded capture date or SP-API version, so a stale fixture is undetectable — adding provenance metadata would close the drift risk left by item 26. |
| 35 | Smoke tests for deploys | **Not applicable** | Nothing is deployed — the artifact is a gem consumed by other applications | Profile-backed. |

## Environment & Tooling

| # | Practice | Status | Evidence | Recommendation / rationale |
|---|----------|--------|----------|----------------------------|
| 36 | Devcontainer config | **Partial** | No `.devcontainer/` and no `.ruby-version`, but CI pins an explicit three-version Ruby matrix with `bundler-cache: true`, so the tested environments are precisely defined — even though a contributor's local Ruby is not | Add a `.ruby-version` matching the primary supported version. See the findings note on which versions those are. |
| 37 | One-command setup (make dev) | **Gap** | No `bin/setup` script, and the README documents installation of the gem rather than setup for contributing to it. A `Rakefile` exists but no setup task | `bin/setup` running `bundle install`, plus a README line pointing contributors at `bundle exec rspec`. |
| 38 | Seed scripts for local databases | **Not applicable** | No database | Profile-backed. |
| 39 | MCP servers for external tools | **Met** | Toolsmith-managed MCP access (owner verified as `patterninc`); no repo-local `.mcp.json` required | Met — Toolsmith-managed MCP access. |
| 40 | Scoped secrets per environment | **Not applicable** | The gem owns no credentials and no environments — SP-API credentials are supplied by the consuming application at construction time, and the test suite uses recorded fixtures rather than real authentication | **Critical gate, declined on profile:** an in-process library with no deployment has no environments to scope credentials to. Consuming applications carry this obligation. |
| 41 | Preview environments per PR | **Not applicable** | Nothing is deployed | Profile-backed. |
| 42 | Hot-reload / watch mode | **Not applicable** | A library whose development loop is running the spec suite; there is no long-running process to reload | Profile-backed. |
| 43 | Structured logging (JSON) | **Not applicable** | The gem emits no logs of its own; diagnostics surface as returned objects and raised errors inside the consuming application, which owns its logging | Profile-backed. |
| 44 | Observable traces and metrics | **Not applicable** | No runtime of its own to observe; SP-API call latency and error rates are observable in consuming applications | Profile-backed. |
| 45 | Feature flags with local overrides | **Not applicable** | No deployed runtime to toggle; behaviour is selected per call by the consumer | Profile-backed. |
| 46 | Database migration tooling | **Not applicable** | No database | Profile-backed. |
| 47 | Dependency update automation | **Met** | Org-wide Wiz coverage for verified Pattern repos (owner verified as `patterninc`) | Met — inherited Pattern Wiz policy. Do not add Dependabot. |
| 48 | Reproducible builds (lockfiles) | **Met** | The gemspec constrains development dependencies explicitly (`webmock ~> 2.1` among them), the CI matrix pins the exact Ruby versions the gem is validated against, and `bundler-cache: true` makes dependency resolution reproducible per matrix leg. For a published gem, deliberately *not* committing `Gemfile.lock` is the correct convention — consumers resolve against their own applications | **Critical gate: Met**, with the library-appropriate interpretation of the practice. |

## Documentation & Context (agent dispatch)

| # | Practice | Status | Evidence | Recommendation / rationale |
|---|----------|--------|----------|----------------------------|
| 49 | Agent-dispatch manifest (`.agents/pattern-agents.json`) | **Gap** | No `.agents/` directory. `backstage.yaml` carries the component identity | Add `.agents/pattern-agents.json` with the core fields. The `aws[]` array does not apply — the gem has no AWS footprint. |

## Prioritized recommendations

Ordered by the scoring reference: incomplete critical gates first (Gap before Partial), then remaining Gaps before remaining Partials, then blast radius, then effort. Effort and current status are shown on every line.

**Critical gates:**

1. **[S] #2 Gap — AGENTS.md.** Record the conventions the code already follows: every endpoint gets a spec and a recorded fixture, `webmock` forbids live HTTP in tests, and CI validates three Ruby versions.
2. **[S] #16 Partial — required CI checks.** Register the `ci-build` matrix jobs as required status checks. The suite and the linter already run on every pull request; nothing enforces the result. **One field, and it is the highest-value change in this repository.**

**Remaining Gaps:**

3. **[S] #29 Gap — coverage thresholds.** Add SimpleCov with a floor. With 42 spec files the number is likely already good; locking it in prevents quiet erosion.
4. **[S] #9 Gap — CODEOWNERS.** 35 contributors on a shared library; route review on the auth and request-signing code at minimum.
5. **[S] #4 Gap — release runbook.** `CHANGELOG.md` records what changed; nothing records how a version is cut, tagged, and published.
6. **[S] #25 Gap — golden-file tests.** Pin the parsed object shape for representative endpoints, so a parsing refactor cannot silently change what consumers receive.
7. **[S] #33 Gap — structured CI output.** A JUnit formatter plus artifact upload, so a failure in one matrix leg is machine-parseable.
8. **[S] #12 Gap — type checking.** RBS signatures double as consumer-facing interface documentation for a published gem.
9. **[S] #49 Gap — agent-dispatch manifest.** Core fields; no `aws[]`.
10. **[S] #37 Gap — one-command setup.** `bin/setup` plus a contributor line in the README.
11. **[M] #30 Gap — mutation testing.** Genuinely the sensible next step here, unlike anywhere else in this batch, because base coverage is real.
12. **[S] #13 Gap — pre-commit hooks**, **[S] #14 Gap — commit conventions**, **[S] #17 Gap — dependency policy**, **[S] #18 Gap — license scanning**, **[S] #32 Gap — flaky quarantine**, **[M] #3 Gap — ADRs**, **[S] #1 Gap — skills.** Lower priority; itemized with rationale in the tables above.

**Remaining Partials:**

13. **[S] #21 Partial — complexity limits.** Confirm RuboCop's `Metrics` cops are enabled rather than excluded in `.rubocop.yml`; if enabled, this is already Met.
14. **[S] #36 Partial — devcontainer.** Add `.ruby-version` matching the primary supported version.

One finding maps to no checklist item but is worth raising:

- **The CI matrix tests Ruby 2.5, 2.6, and 2.7 — all three are past end-of-life.** Ruby 2.5 reached EOL in March 2021, 2.6 in March 2022, and 2.7 in March 2023, so this gem is validated exclusively against unsupported interpreters and against none of the versions its consumers are likely running today. The workflow also uses `actions/checkout@v2`. Extending the matrix to a current Ruby (3.2+) is a small change with real consequences: it is the only way to know whether the gem works where it is actually used. Note the sibling `datadog_notifier` repository documents a Ruby 3.4 compatibility split, so newer interpreters are demonstrably in play at Pattern.

## Declined practices

| # | Practice | Rationale |
|---|----------|-----------|
| 5 | API contract docs (OpenAPI / protobuf) | In-process library with no wire protocol; the SP-API contract it consumes is Amazon's, linked from the README. |
| 8 | On-call playbooks | No deployed runtime; failures surface inside consuming applications. |
| 22 | Import boundary enforcement | Conventional flat gem layout with no architectural layering. |
| 26 | Contract tests (Pact) | Consumer-only integration with Amazon's SP-API; no provider side to verify from here and no service contract published. |
| 27 | End-to-end tests (Playwright) | No browser UI — a Ruby library. |
| 28 | Visual regression tests | No visual surface. |
| 31 | Load / performance benchmarks | Request-per-call client with no throughput characteristic of its own. |
| 35 | Smoke tests for deploys | Nothing is deployed; the artifact is a gem. |
| 38 | Seed scripts for local databases | No database. |
| 40 | Scoped secrets per environment | The gem owns no credentials or environments — consumers supply SP-API credentials at construction time, and tests use recorded fixtures. |
| 41 | Preview environments per PR | Nothing is deployed. |
| 42 | Hot-reload / watch mode | Development loop is the spec suite; no long-running process. |
| 43 | Structured logging (JSON) | Emits no logs of its own; diagnostics surface in the consuming application. |
| 44 | Observable traces and metrics | No runtime of its own to observe. |
| 45 | Feature flags with local overrides | No deployed runtime; behaviour is selected per call by the consumer. |
| 46 | Database migration tooling | No database. |

## Beyond the checklist

- **This is the best-tested repository across all three batches of these audits.** 42 spec files, 102 recorded fixtures, `webmock` enforcing no live HTTP, and a CI job that actually runs them on every push and pull request across three interpreters. Nearly every other repository audited in this programme has tests that do not run, or no tests at all.
- **CI runs a linter *and* a test suite.** `bundle exec rspec` followed by `bundle exec rubocop` — unique in this batch. Most repositories here run a build and call it CI.
- **A maintained `CHANGELOG.md` next to a versioned gem.** Two repositories out of thirty-plus audited have one. For a library other applications depend on, it is the artifact that makes upgrading a decision rather than a gamble.
- **The recorded-fixture strategy is the right architecture for a third-party API client**, and it was applied consistently across 102 files rather than for the first few endpoints and then abandoned — which is the usual failure mode.
- **The README carries a CI badge.** Small, but it means a broken build is visible on the front page rather than buried in the Actions tab — the same instinct seen in `serp` and `review-collector`.
