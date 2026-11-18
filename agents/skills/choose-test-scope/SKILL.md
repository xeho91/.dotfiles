---
name: Choose Test Scope
description: >-
  Use this skill when deciding whether a code change needs a new test,
  whether existing tests cover the changed behavior,
  or which test scope fits.
  Trigger for test-planning requests before test work begins.
---

# Choose Test Scope

Assess whether the behavior needs new test coverage.
If it does, recommend the scope that covers the risk without duplicating
existing tests.

## Required Format

The report must contain only these four fields, in this order.
Replace each placeholder.
Ask for confirmation after you show the report.

**Decision** must be exactly one of:

- `No new test`
- `Unit`
- `Integration`
- `Other: <test_type>`

```md
**Decision:** <selected_decision>

**Behavior:** <behavior_under_consideration>

**Coverage evidence:** <what_a_checked_test_proves_or_the_gap>

**Reason:** <why_this_one_decision_fits_the_risk>
```

### Decision-Specific Rules

1. For `No new test`, state what existing test covers the behavior.
2. If the change cannot affect behavior, state why no regression risk exists.
3. For `Other`, name the test type
   and explain why the defined test scopes cannot provide the needed evidence.
4. Recommend one test level per request.

> [!CAUTION]
> Do NOT combine test levels.

---

## Decision Criteria

- Inspect the relevant code and tests.
- Follow project definitions for test types.

> [!CAUTION]
> Do NOT assume that existing tests are correct.

Count an existing test as valid coverage only when all these points are true:

1. Its input exercises the behavior.
2. Its scope covers the behavior at risk.
3. If the risk involves a dependency interaction,
   the test exercises it rather than bypassing it.
4. Its assertion fails when the expected behavior is broken.

### `No new test`

- Choose when the change cannot affect observable behavior.
  This includes documentation-only changes.

- Choose when a valid existing test covers the changed behavior.

- Observable behavior includes public contracts, errors, stored data,
  and dependency interactions.

> [!CAUTION]
> Do NOT add tests only to increase coverage metrics.

### Choose the Test Level

- Ask:
  > "Can a Unit or Integration test provide the required evidence?"
  - **Yes**: continue to the next question.
  - **No**: choose [`Other: <test_type>`](#other-testtype) and name the test type.

- Ask:
  > "Can the risk be checked without testing the dependency interaction?"
  - **Yes**: choose [`Unit`](#unit).
  - **No**: choose [Integration](#integration).

### `Integration`

- Choose when the risk involves the application's interaction
  with a dependency boundary.

- Examples include:
  - persistence
  - filesystem behavior
  - message-broker behavior
  - service interfaces

- Use a real dependency or a controlled test double as appropriate.

- If local logic and a dependency both apply,
  choose this scope when the boundary interaction is at risk.

- Choose for serialization
  only when the serialized format is part of a dependency contract.

> [!IMPORTANT]
> Keep each test focused on one dependency interaction.
> Include the application modules needed to test it,
> but **exclude unrelated flows and dependencies**.

### `Unit`

- Choose for observable behavior exposed by a function, module, or class.
  Check this behavior without exercising a dependency boundary.

- Choose for a local data transformation that does not cross a boundary.

- If local logic and a dependency both apply,
  choose this scope when the local logic is the risk.

### `Other: <test_type>`

- Use another test type
  when the risk needs evidence that the defined test scopes cannot provide.

- Name the test type in the recommendation.

- Examples include:
  - Contract tests
  - User-interface tests
  - E2E tests for a broader system flow
  - Load tests for capacity under expected traffic

---

## Get Agreement on the Recommendation

After you show the report:

1. Use the built-in question prompt to ask if the user
agrees.
2. Offer:
   - `Agree`
   - `Partly agree`
   - `Disagree`

> [!CAUTION]
> Do NOT do test work until the user agrees with the recommendation.

If the user chooses `Partly agree` or `Disagree`:

1. Ask what should change or which assumption is wrong.
2. Ask why.
3. Wait for the user's clarification.
4. Revise the report and ask if the user agrees again.

Repeat this loop until the user agrees or explicitly ends the discussion
without agreement.

---

## Record Feedback

1. After the user agrees or explicitly ends the discussion without agreement,
   append one JSON object on one line to `feedback.jsonl` next to this file.
2. Record one entry for the exchange,
   not one entry for each answer during a revision loop.
3. Set `date` to the current date in `YYYY-MM-DD` format.
4. Set `decision` to the decision in the final report.
5. Set `agreement` to `agree` if the user agrees,
   or `ended_without_agreement` if the user ends the discussion without agreement.
6. Set `feedback` to the user's concern or reason.
7. Set `suggested_change` to the change the user requests.
8. Set `clarification` to the user's clarification.
   Use an empty string for `feedback`, `suggested_change`,
   or `clarification` when the user provides no such detail.

> [!IMPORTANT]
> Agreement alone counts as feedback.

If the user partly disagrees, clarifies, then agrees,
record the final decision and agreement.
Include their concern, requested change, and clarification in the same entry.

Example:

```json
{"date":"2026-11-18","decision":"Unit","agreement":"agree","feedback":"","suggested_change":"","clarification":""}
```

> [!CAUTION]
> Do NOT add an entry if the user skips the prompt or does not answer.

Proceed with test work only after the user agrees and requests implementation.

> [!IMPORTANT]
> If the user agrees but does not request implementation,
> stop after recording the agreement.

Only use the next skills when the user requests implementation:

- For `Unit`, use [Write Unit Tests](../write-unit-tests/SKILL.md).
- For `Integration`, use [Write Integration Tests](../write-integration-tests/SKILL.md).
- For `Other: <test_type>`, explain what test type or evidence the user needs.

---

## References

- [Practical Test Pyramid by Martin Fowler](https://martinfowler.com/articles/practical-test-pyramid.html)
