# Security Checklist

Quick reference for web application security.
Use alongside the [`security-and-hardening` skill](../skills/security-and-hardening/SKILL.md).

## Threat Modeling

Before reaching for controls, spend five minutes thinking like an attacker:

- [ ] Trust boundaries mapped
      _(requests, uploads, webhooks, third-party APIs, LLM output, and local values written by processes you don't control)_
- [ ] Assets named _(credentials, PII[^7], payment data, admin actions, money movement)_
- [ ] STRIDE[^1] run per boundary
- [ ] Abuse cases written next to use cases _("how would I misuse this?")_

---

## Pre-Commit Checks

- [ ] No secrets in code _(`git diff --cached | grep -i "password\|secret\|api_key\|token"`)_
- [ ] `.gitignore` covers: `.env`, `.env.local`, `*.pem`, `*.key`
- [ ] `.env.example` uses placeholder values _(not real secrets)_

---

## Authentication

- [ ] Passwords hashed with `bcrypt` _(`≥12` rounds)_, `scrypt`, or `argon2`
- [ ] Session cookies: `httpOnly`, `secure`, `sameSite: 'lax'`
- [ ] Session expiration configured _(reasonable `max-age`)_
- [ ] Rate limiting on login endpoint _(`≤10` attempts per `15` minutes)_
- [ ] Password reset tokens: time-limited _(`≤1` hour)_, single-use
- [ ] Account lockout after repeated failures _(optional, with notification)_
- [ ] MFA[^3] supported for sensitive operations _(optional but recommended)_

---

## Authorization

- [ ] Every protected endpoint checks authentication
- [ ] Every resource access checks ownership/role _(prevents IDOR[^4])_
- [ ] Admin endpoints require admin role verification
- [ ] API keys scoped to minimum necessary permissions
- [ ] JWT[^5] tokens validated _(signature, expiration, issuer)_

---

## Input Validation

- [ ] All user input validated at system boundaries _(API routes, form handlers)_
- [ ] Validation uses allowlists _(not denylists)_
- [ ] String lengths constrained _(`min`/`max`)_
- [ ] Numeric ranges validated
- [ ] Email, URL, and date formats validated with proper libraries
- [ ] File uploads: type restricted, size limited, content verified
- [ ] SQL queries parameterized _(no string concatenation)_
- [ ] HTML output encoded _(use framework auto-escaping)_
- [ ] URLs validated before redirect _(prevent open redirect)_
- [ ] Server-side URL fetches allowlisted; private/reserved IPs blocked _(prevent SSRF[^6])_
- [ ] Destructive path operations _(delete/move/overwrite)_:
      - symlinks resolved
      - allowlisted root
      - minimum depth
      - ownership evidence read before the call

### Destructive Path Operations

Containment for a target named by data.
Resolve first, then decide — and treat the result as a candidate, not as authorization:

```ts
import { realpath, readFile } from 'node:fs/promises';
import { resolve, relative, isAbsolute, join, sep } from 'node:path';

const ALLOWED_ROOTS = ['/var/lib/myapp/sessions']; // an allowlist, not a pattern
const MIN_DEPTH = 1;                               // so a root is never the target

async function resolveDeletable(candidate: string, expectedOwner: string) {
  const target = await realpath(resolve(candidate)); // symlinks resolved BEFORE the check
  const inRoot = ALLOWED_ROOTS.some((root) => {
    const rel = relative(root, target);
    // `rel === '..'` / `'../'` only — a plain `startsWith('..')` would also
    // reject a legitimate child named `..cache`.
    if (rel === '' || rel === '..' || rel.startsWith(`..${sep}`) || isAbsolute(rel)) return false;
    return rel.split(sep).length >= MIN_DEPTH;
  });
  if (!inRoot) throw new Error(`refusing: outside allowed roots (${target})`);

  const owner = await readFile(join(target, '.owner'), 'utf8').catch(() => null);
  if (owner?.trim() !== expectedOwner) throw new Error(`refusing: unproven owner (${target})`);
  return target;
}
```

What this does not do, and must be said where the snippet is copied from:

- **The marker is self-attestation.**
  Anything that can write inside the root can write `.owner`. `expectedOwner` has to come from authenticated state,
  and the marker needs integrity protection _(restrictive ownership, or a MAC)_ before it is authorization
  rather than a consistency check against a misderived target.

- **Returning a path leaves a check/use race.**
  Where an untrusted process can swap an ancestor between the check and the call,
  operate on a descriptor with no-follow, beneath-the-root semantics,
  or guarantee the hierarchy is immutable for the duration.

---

## Security Headers

```txt
Content-Security-Policy: default-src 'self'; script-src 'self'
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 0  (disabled, rely on CSP)
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
```

---

## CORS Configuration

```ts
// Restrictive (recommended)
cors({
  origin: ['https://yourdomain.com', 'https://app.yourdomain.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
})

// NEVER use in production:
cors({ origin: '*' })  // Allows any origin
```

---

## Data Protection

- [ ] Sensitive fields excluded from API responses _(`passwordHash`, `resetToken`, etc.)_
- [ ] Sensitive data not logged _(passwords, tokens, full credit card numbers)_
- [ ] PII[^7] encrypted at rest _(if required by regulation)_
- [ ] HTTPS for all external communication
- [ ] Database backups encrypted

---

## Dependency Security

First locate the **installation boundary**.

If the package is matched by a parent `workspaces` declaration, use that workspace root;
otherwise use the nearest project root that owns both its manifest and dependency graph.
At that boundary, corroborate `packageManager` _(when present)_, the lockfile, and CI commands.

Stop if they disagree or competing manager lockfiles exist there.
A nested project is independent only when it is outside the parent workspace;
independent sub projects may legitimately use different managers.

| Manager/version signal | Frozen/immutable CI install | Known-advisory audit |
| --- | --- | --- |
| npm (`package-lock.json` or `npm-shrinkwrap.json`) | `npm ci` | `npm audit` |
| pnpm | `pnpm install --frozen-lockfile` | `pnpm audit` |
| Yarn 2+ | `yarn install --immutable` | `yarn npm audit -A -R` |
| Yarn 1 | `yarn install --frozen-lockfile` | `yarn audit` |

For an unlisted manager or version, consult its official documentation;
do not substitute another manager's commands or newer defaults.

### Install-Script Gate

Never discover dependency lifecycle scripts by first executing an ordinary install
on a client whose defaults have not been verified.

1. Bootstrap with dependency scripts disabled,
   or with a documented default-deny policy plus fail-closed enforcement.
2. Inspect the exact script source and package version before approval.
3. Record the narrowest native allow/deny policy at the installation boundary and commit it.
4. Run a clean frozen/immutable install with that policy and verify the required packages still build.

**Point-in-time snapshot:**
Package-manager defaults and command names change quickly.
Verify this matrix against the pinned client's current official documentation before relying on it.

| Manager version | Native policy |
| --- | --- |
| npm without verified granular approvals | Bootstrap with `npm ci --ignore-scripts`, or persist `ignore-scripts=true` when project-wide blocking is intended. Keep scripts disabled or deliberately upgrade before allowing any reviewed dependency script. |
| npm 11.18.x _(verified on 11.18.0)_ | Unreviewed dependency scripts run with a warning by default. Enforce `strict-allow-scripts=true` before a normal install, then use the workspace-unaware `npm install-scripts ls` from the installation boundary; keep approvals version-pinned and denials name-wide. |
| npm 12.x _(verified on 12.0.1)_ | Unreviewed dependency scripts are skipped by default; `strict-allow-scripts=true` makes their presence fail the install before execution. Use the same `npm install-scripts` review and approval flow. |
| pnpm 11+ | Use `pnpm approve-builds` and commit `allowBuilds` decisions; `strictDepBuilds` defaults to `true`, so unreviewed builds fail. |
| pnpm 10.26–10.x | Configure `allowBuilds` explicitly, or use `pnpm approve-builds` with the legacy `onlyBuiltDependencies` / `ignoredBuiltDependencies` lists. Set `strictDepBuilds: true`; its v10 default is `false`. |
| pnpm 10.1–10.25 | `pnpm approve-builds` records the legacy lists; enable `strictDepBuilds` where supported (10.3+). |
| Older or unknown pnpm | Bootstrap with `pnpm install --frozen-lockfile --ignore-scripts`. Keep scripts disabled unless the pinned version documents an enforceable policy. |
| Yarn 4.14+ | Dependency post installs are disabled by default. Grant only required exceptions with top-level `dependenciesMeta.<package>.built: true`. |
| Yarn 2–4.13 | Set `enableScripts: false` in `.yarnrc.yml`, then grant only required exceptions with top-level `dependenciesMeta.<package>.built: true`; do not enable scripts globally. |
| Yarn 1 | Bootstrap with `yarn install --ignore-scripts`; keep scripts disabled unless each required exception is reviewed under the pinned client's documented workflow. |

Authoritative checks:

- [npm install-scripts](https://docs.npmjs.com/cli/v11/commands/npm-install-scripts/)
- [npm install policy](https://docs.npmjs.com/cli/v11/commands/npm-install/)
- [npm CLI releases](https://github.com/npm/cli/releases)
- [pnpm approve-builds](https://pnpm.io/cli/approve-builds)
- [pnpm build settings](https://pnpm.io/settings#allowbuilds)
- [Yarn security](https://yarnpkg.com/features/security)
- [Yarn manifest](https://yarnpkg.com/configuration/manifest#dependenciesMeta)

### Supply-Chain Hygiene

Advisory audits do not catch newly malicious packages:

- [ ] Exactly one authoritative lockfile per project/workspace root is committed and CI never rewrites it
- [ ] Critical/high findings are triaged for reachability; deferrals have a reason and review date
- [ ] Forced audit remediation _(`npm audit fix --force` or equivalent)_ is never automatic;
      remediation diffs and changelogs are reviewed
- [ ] Registry signatures/provenance are verified where the manager supports it
- [ ] Dependency lifecycle scripts are blocked before first execution
      and approved only through the pinned manager's native policy
- [ ] New dependencies are reviewed for ownership, maintenance, release age,
      provenance, transitive graph, and typosquatting

---

## AI / LLM Security

For any feature that calls an LLM _(chatbots, summarizers, agents, RAG)_:

- [ ] Model output treated as untrusted — never into `eval`/SQL/shell/`innerHTML`/file paths
- [ ] Prompt injection assumed; permissions enforced in code, not in the system prompt
- [ ] Secrets, cross-tenant data, and full system prompts kept out of the context window
- [ ] Tool/agent permissions scoped; destructive or irreversible actions require confirmation
- [ ] Token, rate, and recursion/loop limits set _(bound consumption)_

---

## Error Handling

```ts
// Production: generic error, no internals
res.status(500).json({
  error: { code: 'INTERNAL_ERROR', message: 'Something went wrong' }
});

// NEVER in production:
res.status(500).json({
  error: err.message,
  stack: err.stack,         // Exposes internals
  query: err.sql,           // Exposes database details
});
```

---

## OWASP Top 10 Quick Reference

| # | Vulnerability | Prevention |
| --- | --- | --- |
| 1 | Broken Access Control | Auth checks on every endpoint, ownership verification |
| 2 | Cryptographic Failures | HTTPS, strong hashing, no secrets in code |
| 3 | Injection | Parameterized queries, input validation |
| 4 | Insecure Design | Threat modeling, spec-driven development |
| 5 | Security Misconfiguration | Security headers, minimal permissions, audit deps |
| 6 | Vulnerable Components | The ecosystem's dependency audit _(`npm audit`, `pip-audit`, ...)_, keep deps updated, minimal deps |
| 7 | Auth Failures | Strong passwords, rate limiting, session management |
| 8 | Data Integrity Failures | Verify updates/dependencies, signed artifacts |
| 9 | Logging Failures | Log security events, don't log secrets |
| 10 | SSRF[^6] | Validate/allowlist URLs, restrict outbound requests |

---

## OWASP Top 10 for LLMs Quick Reference

For apps with LLM features. See the [OWASP GenAI Security Project](https://genai.owasp.org/llm-top-10/).

| ID | Risk | Prevention |
| --- | --- | --- |
| `LLM01` | Prompt Injection | Don't trust the system prompt as a boundary; enforce permissions in code |
| `LLM02` | Sensitive Information Disclosure | Keep secrets/PII out of prompts; filter outputs |
| `LLM03` | Supply Chain | Vet models, datasets, and plugins like any dependency |
| `LLM04` | Data and Model Poisoning | Use trusted model sources, verify integrity; vet fine-tuning and RAG data |
| `LLM05` | Improper Output Handling | Treat model output as untrusted; validate, parameterize, encode |
| `LLM06` | Excessive Agency | Scope tool permissions; confirm destructive actions |
| `LLM07` | System Prompt Leakage | Assume the system prompt can leak; put no secrets in it |
| `LLM08` | Vector and Embedding Weaknesses | Partition RAG embeddings per tenant; validate documents before indexing |
| `LLM09` | Misinformation | Ground answers with citations; validate critical claims; keep a human in the loop |
| `LLM10` | Unbounded Consumption | Cap tokens, request rate, and loop/recursion depth |

---

[^1]: STRIDE - abbreviation for: _Spoofing Tampering Repudiation Info disclosure DoS[^2] Elevation_
[^2]: DoS - abbreviation for: _Denial of Service_
[^3]: MFA - abbreviation for: _Multi-Factor Authentication_
[^4]: IDOR - abbreviation for: _Insecure Direct Object Reference_
[^5]: JSON - abbreviation for: _JSON Web Token_
[^6]: SSRF - abbreviation for: _Server-Side Request Forgery_
[^7]: PII - abbreviation for: _Personally Identifiable Information_
