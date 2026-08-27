# Rules

## Context7

When the Context7 MCP is connected, always use it where applicable:

- _(`resolve-library-id` + `query-docs`)_ for library/API documentation, code generation, and setup or configuration steps without being explicitly asked.
- Prefer it over web search or training data for library-specific APIs, even well-known ones.
- If the exact library is already known, skip resolution and pass its Context7 ID directly (slash syntax, e.g. `/supabase/supabase`).
- Mention specific versions in queries when relevant (e.g. "Next.js 14 middleware").
- Do not use it for refactoring, debugging business logic, code review, or general programming concepts.

## Serena

When the Serena MCP is connected, always use it where applicable:

- Prefer symbolic tools (`find_symbol`, `find_referencing_symbols`, `get_symbols_overview`) over text-based search for code navigation and understanding.
- At the start of work on a project, call `list_memories` and read relevant ones, inferring relevance from names; follow `mem:`-prefixed references between memories.
- Follow the `memory_maintenance` conventions of each project; write memories only when durable knowledge emerges or the user asks, keeping them dense, human-readable Markdown.
- Respect `read_only_memory_patterns` and `ignored_memory_patterns`; never edit `global/` memories unless explicitly asked.
- Remember: onboarding runs once per project (when `.serena/memories/` is empty) — after completing it, suggest starting a fresh conversation.
