---
name: Write Integration Tests
description: >-
  Use this skill when writing or changing an integration test for an
  application boundary, such as a database, filesystem, queue, or HTTP service.
  Use it to reproduce bugs in serialization, persistence, or communication.
  When the task is to choose a test level, use choose-test-scope first.
---

# Write Integration Tests

Write focused integration tests for observable application behavior at a
dependency boundary. Use this skill after the task selects integration testing
or asks you to write an integration test. Test boundaries with:

- **Infrastructure dependencies**, such as databases, filesystems, and message brokers
- **Service interfaces**, such as HTTP APIs and service-to-service messaging

---

## Define the Integration Contract

- An integration test checks how your application interacts with a dependency. Choose one integration point at a time.
- Keep the test focused on the application's use of that dependency, not on proving the dependency itself works.

- Describe its behavior using the language of the people or code that rely on it:
  - **For application flows** - describe business behavior across the flow
  - **For libraries and services** - describe the contract at the boundary

> [!IMPORTANT]
> Describe observable results, not private helper calls or internal state changes.
> Include data read from or written to the dependency when that behavior is part of the contract.

---

## Workflow

1. **Check the test scope and find the coverage gap.**

   - If the task asks which test level fits, use `choose-test-scope` first.
   - Trace the integration point and inspect existing tests at that scope.
   - Add a test when an important dependency interaction lacks coverage.
     Unit tests do not prove that the application interacts correctly with a dependency.
   - Skip tests that duplicate existing integration coverage or combine unrelated integration points.

2. **Inspect the test setup.**

   - Identify the test framework, command, test location, and required services.
   - Read nearby tests to learn setup, fixture, and cleanup requirements.
   - Use the applicable framework skill for syntax and framework-specific conventions.
   - Do not treat existing tests as proof that their style is good.
   - Do not copy weak patterns. Follow this skill if local tests conflict with it.

3. **Choose behavior to protect.**

   - Identify the contract between your application and the dependency.
   - Consider boundary inputs, observable outputs, data read or written, and errors.
   - Choose representative inputs for distinct behavior.
   - Cover important boundary values and error cases.
   - Do not test every possible value or combination.

4. **Write a focused test.**

   > [!IMPORTANT]
   > For a reported bug:
   > 1. Add a test that reproduces it
   > 2. Run the test and check that it fails before you fix the implementation

   - Give each test one behavior
   - Name it after the behavior or outcome
   - Structure it as arrange, act, assert
   - Use a real local or dedicated test dependency when it is safe and deterministic.
   - For a separate service, a controlled test double can check request construction and response handling.
     It does not prove compatibility with the real service.
   - Organize related cases using [Test Organization](#test-organization)
   - For other behavior changes, prefer test-first when practical

5. **Make expectations reviewable.**

   > [!CAUTION]
   > Keep expected values explicit in assertions.

   > [!IMPORTANT]
   > Do NOT hide results behind production constants, computed expectations, or shared fixtures.

   Review the diff as a code reviewer:

   - Can I identify the input at the boundary?
   - Can I tell which behavior at the integration point is under test?
   - Can I see the expected result clearly and explicitly?

   See [Assertions](#assertions) for assertion-specific guidance.

6. **Run and refine.**

   - Run the focused integration test, then the relevant broader integration test command.
   - Isolate and clean up required services and test data.
   - Never point automated integration tests at production services.
     Avoid shared, unreliable, or uncontrolled dependencies.
   - Fix failures without weakening or deleting useful assertions
   - Report the commands run and any checks that could not be run

---

## Test Organization

- Put the main success behavior first in the file
  when that makes the tests easier to scan

- Group related success and error cases
  when it makes the suite easier to scan

- Use shallow groups
  only when they improve navigation

- Use the framework's table-driven feature when several cases exercise the same behavior.
  > [!IMPORTANT]
  > Keep each case's input and the expected result together.

- **Prioritize clarity over "Don't Repeat Yourself" (DRY).**
  Keep setup, action, and expected assertion result visible in each test.
  Some duplication is better than a helper that obscures what the test verifies.
  > [!IMPORTANT]
  > Extract shared setup only when it makes each test easier to understand.

---

## Isolation & Doubles

- **Each test should be independent and safe to run in any order.**
  Use isolated test data and fresh state per test.
  Clean up records, files, messages, and other effects created by the test.
  Use shared setup only when it stays obvious what inputs and expected outcome each test has.

> [!IMPORTANT]
> Clean up mocks, spies, timers, modified global state, and any test-owned external resources.
> They cannot leak into other tests!

- **Keep tests deterministic.**
  Replace time, randomness,
  or other unstable values only when they affect the behavior under test.

- **Exercise the intended integration point.**
  Prefer a real dependency, such as a local database or filesystem, when it is practical and deterministic.
  For a separately deployed service,
  configure a controlled test double through the same boundary as production.
  Keep the test focused on your application's request and response handling.
  > [!CAUTION]
  > A test double does not prove compatibility with the real service.
  > Use contract tests or a dedicated test instance when that compatibility must be verified.

---

## Assertions

- **Expected values:**
  - Write expected values directly in assertions
  - Do NOT use production constants, computed values, or shared fixtures as expectations.
    **Why?** They can change with the implementation and hide regressions.

- **Parameterized cases:**
  - Use the framework's table-driven feature when several cases exercise the same behavior.
  - Keep each case's inputs and the expected value together in the table.
  - Use other referenced expectations only when necessary,
    and explain why in the test

- **Objects & Instances:**
  - Prefer one structural assertion over several property-by-property assertions
  - Assert the complete structure when all fields are part of the contract.
  - Assert only the relevant fields when the contract covers a deliberate subset.
  - Assert data read from or written to the dependency when it is part of the integration contract

- **Matchers:**
  - Choose the narrowest clear matcher that expresses the contract
  - Do NOT add redundant assertions that restate the same result

- **Snapshots:**
  - Prefer explicit assertions for small, stable values
  - Use snapshots when the serialized output itself is the contract
    and its diff is useful in review

---

## Completion Checklist

- [ ] This test protects important behavior across components that is not already covered.
      See [Workflow](#workflow)

- [ ] The integration point is explicit.
      Choose real dependencies or controlled test doubles intentionally.
      See [Define the Integration Contract](#define-the-integration-contract) and [Isolation & Doubles](#isolation--doubles)

- [ ] Each test focuses on one behavior and uses business or public-API language.
      See [Define the Integration Contract](#define-the-integration-contract) and [Test Organization](#test-organization)

- [ ] A reviewer can identify the input, behavior,
      and explicit expected assertion result from the diff.
      See [Assertions](#assertions)

- [ ] Cases cover meaningful success, boundary,
      and error behavior without exhaustive or duplicate cases.
      See [Workflow](#workflow) and [Test Organization](#test-organization)

- [ ] Tests are deterministic and order-independent.
      Each test isolates its data and cleans up its own state and resources.
      See [Isolation & Doubles](#isolation--doubles)

- [ ] Control test doubles for separate services.
      Do not treat them as proof of contract compatibility.
      Clean up test resources.
      See [Isolation & Doubles](#isolation--doubles)

- [ ] Run the focused integration test and the relevant broader integration test command.
      Report the commands and results.
      See [Workflow](#workflow)

- [ ] After completing the test work, offer the optional structured feedback prompt.
      A response is not required.
      See [Optional Skill Feedback](#optional-skill-feedback)

---

## Optional Skill Feedback

After completing a task that adds or changes integration tests,
offer an optional, structured way to improve this skill:

- Use the built-in question prompt or tool.
  Do not ask in plaintext.

- Ask these specific questions:
  > 1. Did the guidance help choose the right behavior to test? _(`Yes` / `Partly` / `No`)_
  > 2. Was anything unclear, missing, or overly restrictive?
  > 3. What concrete change would make the skill more useful?

- Make feedback optional.
  Include a clear skip/no-feedback choice.
  > [!CAUTION]
  > Do NOT ask again if the user skips.

- After the user provides substantive feedback,
  append one JSON object on one line to `evals/feedback.jsonl`
  with `date`, `usefulness`, `feedback`, and `suggested_change` fields.
  Use an empty string for fields the user did not answer.
  > [!CAUTION]
  > Do NOT record task code, sensitive details, or feedback the user did not provide.

> [!CAUTION]
> Do NOT create an entry for skipped or empty feedback.

---

## References

- [Practical Test Pyramid by Martin Fowler - Integration tests](https://martinfowler.com/articles/practical-test-pyramid.html#IntegrationTests)
