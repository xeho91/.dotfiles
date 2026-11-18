---
name: Write Unit Tests
description: >-
  Use this skill to implement user-approved Unit tests,
  including regression tests for bugs.
  Use it after choose-test-scope recommends Unit, the user agrees, and the user requests implementation.
---

# Write Unit Tests

Use this skill to implement a user-approved Unit-test decision.
Write focused tests for a unit's public behavior.
They should catch regressions and make refactoring safer.

> [!IMPORTANT]
> **Prioritize important business rules and high-risk public API behavior**.
> Write only enough tests to _protect_ distinct behavior.

> [!IMPORTANT]
> **A human reviewer should understand the behavior under test.**
> The diff during code review process should _explicitly_ show expected results directly.

> [!CAUTION]
> Do NOT hide results behind constants or helpers.

---

## Define the Unit's Contract

- A unit can be a function, module, or class.
  There is no universal size rule.

- Describe its behavior using the language of the people or code that rely on it:
  - **For application logic** - describe business behavior
  - **For libraries and utilities** - describe the public API contract

> [!CAUTION]
> Do NOT test private or nonpublic methods directly.
> Test observable results through the public interface,
> not private helper calls or internal state changes.

---

## Workflow

1. **Check the implementation gate.**

   - `choose-test-scope` recommends `Unit`.
   - The user agrees with the recommendation.
   - The user requests implementation.

   If no Unit recommendation exists, stop and use `choose-test-scope`.
   If the user has not agreed or has not requested implementation, stop.
   Do NOT write or change tests until all three conditions are true.

2. **Inspect the test setup.**

   - Recheck the relevant implementation and existing tests.
   - If valid existing coverage already protects the behavior,
     stop, and report it.
   - If the risk now involves a dependency interaction,
      stop, and return to `choose-test-scope`.
   - Identify the test framework, test command, and relevant test locations
   - Read nearby tests only to learn necessary mechanics, such as setup or helpers
   - Do NOT treat existing tests as proof that their style is good
   - Do NOT copy weak patterns just because they already exist
   - Apply this skill's guidance when existing tests disagree

3. **Choose behavior to protect.**

   - Identify the contract. Consider:
     - Inputs
     - Outputs
     - Externally visible side effects
     - Errors
   - Choose representative inputs for each distinct behavior
   - Include important boundaries and error cases
   > [!CAUTION]
   > - Do NOT add a test for every possible value or combination

4. **Write a focused test.**

   > [!IMPORTANT]
   > For a reported bug:
   > 1. **Add a test that reproduces it**
   > 2. Run the test and **check that it fails before fixing the implementation**

   - Give each test one behavior
   - Name it after the behavior or outcome
   - Structure it as arrange, act, assert
   - Organize related cases using [Test Organization](#test-organization)
   - For other behavior changes, prefer test-first when practical

5. **Make expectations reviewable.**

   Review the diff as a code reviewer:
   - Can I identify the input?
   - Can I tell which behavior is under test?
   - Can I see the expected result clearly and explicitly?

   See [Assertions](#assertions) for assertion-specific guidance.

6. **Run and refine.**

   - Run the focused test, then the relevant broader test command
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

- **Prioritize clarity over "Don't Repeat Yourself" (DRY).**
  Keep setup, action, and expected assertion result visible in each test.
  Some duplication is better than a helper that obscures what the test verifies.
  > [!IMPORTANT]
  > Extract shared setup only when it makes each test easier to understand.

### Vitest Test Organization

- Use named functions, classes, and class methods as `describe` titles
  to infer the suite name:
  - Pass the function reference. Do not call it.
  - This preserves IDE/LSP code navigation to the function or method
  - Use an explicit string when the inferred name is unclear

  ```ts
  describe(someNamedFunction, () => {})
  describe(SomeClass, () => {})
  describe(SomeClass.prototype.somePublicMethodName, () => {})
  describe(SomeClass.someStaticMethod, () => {})
  ```

- Prefer `it.each` for a compact table of cases exercising the same behavior

See [Assertions](#assertions) for how to keep expected values explicit in each row.

---

## Isolation & Doubles

- **Each test should be independent and safe to run in any order.**
  Create fresh state per test.
  Use shared setup only when it stays obvious
  what inputs and expected outcome each test has.

> [!IMPORTANT]
>
> - **Clean up mocks, spies, timers, and modified global state.
>   They cannot leak into other tests!**

- **Keep tests deterministic.**
  Replace time, randomness,
  or other unstable values only when they affect the behavior under test.

- **Keep internal collaborators real.**
  Avoid mocking them just to isolate the subject or speed up the test.
  > [!CAUTION]
  > Do NOT mock the unit under test.

- **Treat external mocks as a last resort.**
  Prefer _real_ dependencies when they can be used safely and deterministically.
  Use a double only when side effects cannot be controlled.
  Or the real dependency is unavailable or unreliable.
  Slowness alone is not a reason to mock.

---

## Assertions

- **Expected values:**
  - Write expected values directly in assertions
  - Do NOT use production constants, computed values, or shared fixtures as expectations.
    **Why?** They can change with the implementation and hide regressions.

- **Parameterized cases:**
  - `it.each` _(or the framework equivalent)_ is the normal exception
  - Keep each case's inputs and the expected value together in the table
  - Use other referenced expectations only when necessary,
    and explain why in the test

- **Objects & Instances:**
  - Prefer one structural assertion over several property-by-property assertions
  - Use `toEqual()` when the complete structure and values are part of the contract
  - Use `toMatchObject()` when only a deliberate subset matters
    and include the fields that define the behavior under test

- **Matchers:**
  - Choose the narrowest clear matcher that expresses the contract
  - Do NOT add redundant assertions that restate the same result

- **Snapshots:**
  - Prefer explicit assertions for small, stable values
  - Use snapshots when the serialized output itself is the contract
    and its diff is useful in review

### Vitest Assertion Examples

```ts
it('returns the normalized customer', () => {
  expect(normalizeCustomer({ name: ' Ada ' })).toEqual({
    name: 'Ada',
    status: 'active',
  })
})

it('includes the requested customer fields', () => {
  expect(findCustomer('c-17')).toMatchObject({
    id: 'c-17',
    status: 'active',
  })
})

it.each([
  { input: ' Ada ', expected: 'Ada' },
  { input: 'Grace', expected: 'Grace' },
])('normalizes "$input" to "$expected"', ({ input, expected }) => {
  expect(normalizeName(input)).toBe(expected)
})
```

---

## Completion Checklist

- [ ] This test protects important behavior that is not already covered.
      See [Workflow](#workflow)

- [ ] Each test focuses on one behavior and uses business or public-API language.
      See [Define the Unit's Contract](#define-the-units-contract) and [Test Organization](#test-organization)

- [ ] A reviewer can identify the input, behavior,
      and explicit expected assertion result from the diff.
      See [Assertions](#assertions)

- [ ] Cases cover meaningful success, boundary,
      and error behavior without exhaustive or duplicate cases.
      See [Workflow](#workflow) and [Test Organization](#test-organization)

- [ ] Tests are deterministic and order-independent.
      See [Isolation & Doubles](#isolation--doubles)

- [ ] Internal collaborators remain real.
      Any external mocks are necessary, not used just for speed, and cleaned up.
      See [Isolation & Doubles](#isolation--doubles)

- [ ] Run the focused test and relevant broader test command.
      Report the commands and results.
      See [Workflow](#workflow)

- [ ] After completing the test work, offer the optional structured feedback prompt.
      A response is not required.
      See [Optional Skill Feedback](#optional-skill-feedback)

---

## Optional Skill Feedback

After completing a task that adds or changes unit tests,
offer an optional, structured way to improve this skill:

- Use the built-in question prompt or tool.
  > [!CAUTION]
  > Do NOT ask in plaintext.

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
>
> - Do NOT record task code, sensitive details, or feedback the user did not provide.
> - Do NOT create an entry for skipped or empty feedback.

---

## References

- [Practical Test Pyramid by Martin Fowler - Unit tests](https://martinfowler.com/articles/practical-test-pyramid.html#UnitTests)
- [Vitest testing framework - Testing in Practice](https://vitest.dev/guide/learn/testing-in-practice#testing-in-practice)
