# OpenAI plugins

Skills-based plugins for ChatGPT and Codex. Each plugin contains its instructions, OpenAI presentation metadata, icon, and license.

## Available plugins

These plugins help Russian-speaking learners study English and Finnish. They provide explanations in Russian.

| Plugin               | Purpose                                                                                      |
| -------------------- | -------------------------------------------------------------------------------------------- |
| `english-dictionary` | Explain English words, pronunciation, forms, and expressions in Russian.                     |
| `english-errors`     | Identify recurring English errors and provide focused practice with explanations in Russian. |
| `english-grammar`    | Practice English grammar through exercises and feedback in Russian.                          |
| `english-teacher`    | Learn English through translation, explanations in Russian, and practice.                    |
| `english-writing`    | Improve English texts with corrections and explanations in Russian.                          |
| `suomi-dictionary`   | Explain Finnish words, pronunciation, forms, and expressions in Russian.                     |
| `suomi-grammar`      | Practice Finnish grammar through exercises and feedback in Russian.                          |
| `suomi-teacher`      | Learn Finnish with explanations in Russian, including standard and spoken Finnish.           |
| `suomi-yki`          | Prepare for the Finnish YKI examination with guidance in Russian.                            |

## Requirements

Installation needs Codex with plugin support. Maintenance commands need Make, a POSIX shell, zip, Git, and GitHub CLI. Use `gh auth login` before a GitHub release.

## Install in Codex

1. Add the marketplace:

   ```sh
   codex plugin marketplace add ivanlemeshev/openai-plugins
   ```

2. Replace `PLUGIN_NAME` with a name from the table above and install it:

   ```sh
   codex plugin add PLUGIN_NAME@lem-plugins
   ```

3. Start a new session and ask Codex to use the installed plugin.

To use a local checkout, replace `ivanlemeshev/openai-plugins` in the first command with its absolute path. The marketplace name stays `lem-plugins`. To select a released snapshot, add `--ref v1.0.0` to the marketplace command and replace the tag with the release you need.

To refresh a marketplace that follows the default branch, run:

```sh
codex plugin marketplace upgrade lem-plugins
```

A marketplace pinned to a tag stays at that tag. Install the updated plugin through the plugin browser and start a new session.

## Install in the ChatGPT desktop app

1. Clone this repository on the machine that runs the ChatGPT desktop app:

   ```sh
   git clone https://github.com/ivanlemeshev/openai-plugins.git
   ```

2. Register the local checkout with Codex from the same operating system and user profile as the desktop app:

   ```sh
   codex plugin marketplace add /absolute/path/to/openai-plugins
   ```

3. Restart the ChatGPT desktop app. Open Plugins and select the Lem Plugins marketplace source.
4. Install the plugin you need. Start a new chat and use `@` to select it.

For an existing account plugin, open Plugins, select that plugin, and choose Edit Plugin. Provide the updated package or requested changes in the editing conversation. Keep the existing plugin identity. Follow the [OpenAI editing guide](https://learn.chatgpt.com/docs/build-plugins#edit-an-existing-plugin).

## Create a plugin ZIP

Replace `PLUGIN_NAME` with a name from the table above:

```sh
make package PLUGIN=PLUGIN_NAME
```

The ZIP appears at `dist/PLUGIN_NAME.zip`. It contains one complete plugin, including its manifest, license, skills, and assets. Use this package when the OpenAI import or editing flow requests an archive. Follow [OpenAI packaging instructions](https://developers.openai.com/plugins/build/plugins) for the target account or workspace.

## Release

The repository and all plugins use one shared version. The root `VERSION` file records this version. The release command updates every `plugin.json` before it builds the ZIP files.

Choose a new version and run from `main`:

```sh
make release VERSION=1.0.1
```

Replace `1.0.1` with the new version. If you already update the root `VERSION` file, use `make release`.

The command updates `VERSION` and all plugin versions, builds the plugin ZIPs, commits all repository changes, creates the release tag, and pushes `main` and the tag. It then creates a GitHub release with the ZIPs as download assets. A failed push stops publication. Review your changes before running it.

If a push or GitHub publication fails after the local release tag exists, finish that release with these commands:

```sh
git push --atomic origin main "v$(cat VERSION)"
gh release create "v$(cat VERSION)" dist/*.zip --verify-tag --generate-notes --title "v$(cat VERSION)"
```

## Publish in ChatGPT

A GitHub release distributes the source and ZIP files. To publish a plugin to a ChatGPT workspace, open its entry under Personal in Plugins and use Publish when your workspace permissions allow it. Follow the [workspace publication guide](https://developers.openai.com/plugins/build/plugins#publish-a-local-plugin-to-your-workspace).

A public OpenAI directory listing needs a separate submission and review. Follow the [OpenAI submission guide](https://developers.openai.com/plugins/deploy/submission). The Makefile creates GitHub releases only.

## Repository layout

```text
.agents/plugins/marketplace.json
plugins/
  PLUGIN_NAME/
    plugin.json
    LICENSE
    assets/logo.png
    skills/
      SKILL_NAME/
        SKILL.md
```

The marketplace paths start at the repository root. Each plugin follows the Agent Plugins format. Skills use the Agent Skills format. Each plugin package contains one skill.

## Update or add a plugin

Keep plugin files inside `plugins/PLUGIN_NAME/`. Keep its folder name and manifest name equal. Keep the skill folder name and skill name equal. Put OpenAI presentation settings under `extensions.com.openai` in `plugin.json`.

Use the next shared release version for plugin changes. The release command updates the manifest versions. Preserve existing names and presentation settings unless the change requires an update. Add new plugins to the marketplace and the table above.

Keep each plugin package self-contained. Follow the [Agent Plugins format](https://agent-plugins.org/schemas/1.0.0/plugin.schema.json).

## License

[MIT](LICENSE).
