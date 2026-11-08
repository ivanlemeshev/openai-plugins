# Agent instructions

Use Simplified Technical English for new repository documentation and code comments. Preserve the language and wording of existing skill instructions unless the user requests a content change. Use LF line endings.

Write Markdown prose in normal paragraphs. Keep each paragraph on one source line. Do not insert a line break after each sentence or wrap prose at a fixed column width. Separate paragraphs with a blank line.

Use the Agent Plugins format for plugin packages. Use the Agent Skills format for bundled skills. Preserve existing plugin identities, versions, and presentation settings unless the task requires a change. Keep each plugin self-contained. Keep marketplace paths relative to the repository root.

Inspect the worktree before changes. Preserve unrelated work. Review the final diff. Commit, push, publish, and change account-installed plugins only when the user requests these actions.

Validate JSON manifests and YAML frontmatter. Check skill names, package paths, and referenced assets. Use temporary directories for verification. Keep credentials and runtime state outside the repository.
