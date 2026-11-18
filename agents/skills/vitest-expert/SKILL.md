---
name: Vitest Expert
description: >-
  Use this skill when writing or reviewing Vitest tests in this repository and
  you need local test organization or assertion conventions. Use the `vitest`
  skill for Vitest API, syntax, and configuration details.
---

# Vitest Expert

Use this skill for local Vitest conventions. Do not copy or restate the API
guidance from the generated `vitest` skill. Load that skill when you need current
Vitest syntax, configuration, or feature details.

Use [Write Integration Tests](../write-integration-tests/SKILL.md) for guidance
on integration boundaries, dependency selection, and integration-test behavior.

## Test Organization

- Prefer a named function, class, or method as the suite title when the suite
  tests that symbol and the title helps editor navigation.
- Use a clear string title for a behavior, flow, or boundary contract. Use a
  string title when a symbol name does not explain the suite.
- Keep suites shallow. Group tests only when grouping makes the suite easier to
  navigate.
- Use table-driven tests when several cases exercise the same behavior. Keep
  each case's input and expected result together. Use separate tests when cases
  represent different behavior.

## Assertions

- Keep expected values visible in the test or next to each table-driven case.
- Use a full structural assertion when the complete value is part of the
  contract. Use a partial structural assertion when only named fields matter.
- Choose the narrowest assertion that states the expected behavior. Do not add
  assertions that repeat the same result.
- Load the `vitest` skill for matcher names and syntax.

## Workflow

1. Read the repository's Vitest configuration and relevant nearby tests.
2. Apply these local conventions without copying existing patterns that obscure
   the behavior under test.
3. Load the `vitest` skill when you need API details or current feature guidance.
4. Run the focused test and the relevant broader test command.
5. Report commands and checks that you could not run.
