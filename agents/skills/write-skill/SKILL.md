---
name: Write Skill
description: >-
  Use this skill to create or update an agent skill's `SKILL.md`.
  Use it when defining a skill's purpose, triggers, workflow, or instructions.
  Ask focused questions when missing details could change the skill's purpose
  or workflow.
---

# Write Skill

Create or update one agent skill's `SKILL.md` file.
Keep broad review and supporting files out of scope unless the user asks for them.

## Workflow

1. **Define the requested change.**

   - Identify whether the user wants a new skill or an update.
   - Identify the skill's purpose and intended users.
   - For an update, read the current `SKILL.md` and preserve unrelated content.
   - Ask a focused question only when missing information could change the
     purpose or workflow.

2. **Read the skill creation guidance.**

   Use the [Agentskills best-practices guide](https://agentskills.io/skill-creation/best-practices).
   Ground the skill in the user's expertise, examples, project guidance, or
   other supplied source material. Do not fill gaps with generic advice.

3. **Draft or update `SKILL.md`.**

   - For a new skill, ask the user where to save it before creating files.
     Do not assume a project-local or global path.
   - Use a lowercase kebab-case directory name for the skill ID.
   - Set `name` to a readable display name.
   - Start `description` with when to use the skill. Describe user intent,
     include useful trigger cases, and keep it concise.
   - Give the body a clear purpose and a procedure the agent can follow.
   - Make required inputs, decision rules, and outputs explicit.
     Aim for consistent decisions and output formats when inputs match.
   - Include only details the agent needs for this task.
     Prefer concrete steps over general advice.
   - Keep the scope coherent. Add examples only when they prevent ambiguity.
   - Keep each skill focused on one coherent area of expertise or task.
     Split unrelated goals into separate skills.
   - Keep `SKILL.md` under 500 lines and 5,000 tokens.
     Prefer a much shorter file. Remove repeated rules and details the agent
     already knows. Do not create supporting files to move extra content.

4. **Keep the requested scope.**

   - Edit only the requested `SKILL.md` file.
   - Do not create evaluation files, scripts, references, or other supporting
     files unless the user asks.
   - Do not perform a separate skill review unless the user asks.

5. **Validate the result.**

   - Validate that the file matches the user's request and keeps all required
     conditions and limits.
   - Load `asd-ste100` and run its local linter on the `SKILL.md` file.
    - Fix reported violations and run the linter again.
    - Run `npm run count -- <path-to-SKILL.md>` from this skill's directory
      to measure line and token counts. Keep the file below 500 lines and
      5,000 tokens. The default `o200k_base` token count is an estimate for
      models with an unknown encoding.
    - Report the file path and the linter result.
   - Do not claim full ASD-STE100 compliance unless you compare every word
     with the official dictionary.

## Output

After the change, state what file you created or updated.
State the validation result and any validation step you could not complete.
