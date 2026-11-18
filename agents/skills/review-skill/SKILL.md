---
name: Review Skill
description: >-
  Use this skill to review or validate an agent skill's `SKILL.md` without
  editing it. Use it after creating or updating a skill, or when asked to audit
  an existing skill.
---

# Review Skill

Review skill files. Do not edit them. Report findings and checks so the author
can decide what to change. Use `write-skill` to create or update a skill.

## Review Workflow

1. Read the target `SKILL.md` and identify its purpose, users, and triggers.
   Use the request, sibling skills, and project instructions as evidence.
   Do not invent requirements.
2. Check the frontmatter. Confirm that the name is clear and the description
   starts with when to use the skill. Check that the description names specific
   user intents and avoids unrelated triggers.
3. Check the body. Confirm that it gives a clear workflow, required inputs,
   decision rules, and expected outputs. Check that the guidance is coherent,
   grounded in supplied expertise or sources, and free of repeated or generic
   advice.
4. Check boundaries. Look for conflicts with project instructions, overlap with
   sibling skills, unsafe actions, untrusted instructions, and broken local links.
   Check external tool or API claims against current official documentation when
   those claims affect the guidance.
5. Run the available validators:
   - Find the `asd-ste100` skill's `scripts/ste-lint.py` and run it on the target.
     Report its findings. Do not claim full STE compliance from this linter alone.
   - Run `npm run count -- <path-to-SKILL.md>` from the `write-skill` directory.
     Report line and token counts. Flag files over 500 lines or 5,000 tokens.
   - Check local links and required supporting files. Report any check you cannot run.
6. Report findings. Do not fix them. Include a location, severity, evidence,
   impact, and recommended change for each finding.

## Severity

- **Blocker:** The skill conflicts with an explicit requirement or directs an
  unsafe action.
- **Major:** The skill is likely to activate at the wrong time or cause an
  incorrect result.
- **Minor:** The issue reduces clarity, consistency, or maintainability.

Set the verdict to **Needs changes** if any Blocker or Major finding remains.
Otherwise, set it to **Ready**. A missing check is not a clean result. Report it
as not run and explain why.

## Report Format

```markdown
**Verdict:** Ready | Needs changes

**Findings:**
- [Severity] `path:line` — Evidence. Impact. Recommended change.
- None.

**Checks:**
- STE linter: result
- Size: line count and token count
- Links and source checks: result or not run with reason
```

Keep the report concise. Do not modify the target skill or supporting files.
