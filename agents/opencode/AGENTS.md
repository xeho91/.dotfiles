# Rules

## Writing Style

Use the `asd-ste100` skill for all responses.
Apply its rules to keep text clear and unambiguous.
Preserve meaning, conditions, and uncertainty.

> [!CAUTION]
> Do not claim strict ASD-STE100 compliance
> unless checked against the official dictionary.

## Skill Files

- Before creating or editing any `SKILL.md`, load and follow the `write-skill` skill. This includes small wording changes.

## CLI Commands

When calling CLI commands, prefer full flag names over short aliases whenever practical, for readability.
Avoid `head` and `tail` unless necessary. Use tools that show complete, targeted output. This helps the user understand the result.

## Context7

Use Context7 whenever it applies and the MCP server is available:

- _(`resolve-library-id` + `query-docs`)_ for library/API documentation, code generation, and setup or configuration steps without being explicitly asked.
- Prefer it over web search or training data for library-specific APIs, even well-known ones.
- If the exact library is already known, skip resolution and pass its Context7 ID directly (slash syntax, e.g. `/supabase/supabase`).
- Mention specific versions in queries when relevant (e.g. "Next.js 14 middleware").
- Do not use it for refactoring, debugging business logic, code review, or general programming concepts.

## Serena

Use Serena whenever it applies and the MCP server is available:

- Prefer symbolic tools (`find_symbol`, `find_referencing_symbols`, `get_symbols_overview`) over text-based search for code navigation and understanding.
- At the start of work on a project, call `list_memories`. Read relevant memories based on their names. Follow references that start with `mem:`.
- Follow each project's `memory_maintenance` conventions. Write memories only when durable knowledge emerges or the user asks. Keep memories dense and readable.
- Respect `read_only_memory_patterns` and `ignored_memory_patterns`. Do not edit `global/` memories unless the user asks.
- Remember: onboarding runs once per project (when `.serena/memories/` is empty) — after completing it, suggest starting a fresh conversation.
