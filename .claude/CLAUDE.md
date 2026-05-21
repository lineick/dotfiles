# CLAUDE.md
Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.
**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding
**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain or task is underdefined, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First
**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- Before writing a helper, search for an existing one. If a near-match exists, refactor it - don't duplicate slightly.
- Before adding a flag or branch to an existing function, ask whether it should split into two functions.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes
**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Comments, Docstrings, Formatting
**Code is self-contained. Future readers have no chat context.**

- Comments explain *why*, never *what*. Skip them on self-explanatory lines.
- Use comments sparsely and keep them short and concise.
- Lowercase, terse, no first-letter capitalization, no trailing period on fragments.
- Never reference the conversation or change history. Forbidden patterns:
  - `# changed to handle X`
  - `# updated per request`
  - `# was using Y, now Z`
  - `# new convention`
- ASCII only in code, strings, and comments. No em-dashes, smart quotes, arrows, bullets, box-drawing, or other non-ASCII unicode unless the data itself requires it.
- No banner or separator comments. Forbidden patterns:
  - `# ===== helpers =====`
  - `# ---- main ----`
  - `# ### section ###`
  Organize via files and module structure instead.
- Python: type hints on function signatures. Google-style docstrings, but only when signature + name don't already convey the contract.

## 5. Goal-Driven Execution
**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
````
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
````

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Working Style
- Research code: correctness > clarity > performance. Don't preoptimize. Don't generalize until a second caller appears.
- If exploration exceeds ~3 tool calls without progress, stop and summarize before continuing.

## Tools
- Python: uv (env/deps), ruff (lint/format - run by code-cleanup agent, not automatic), pytest.
- Shell: zsh; OS: Tuxedo OS (Ubuntu) / Fedora.
- Editor: nvim.

---
**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
