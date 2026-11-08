.DEFAULT_GOAL := packages
VERSION ?= $(shell cat VERSION)

.PHONY: package packages release

package:
	@test -n '$(PLUGIN)' && test -f 'plugins/$(PLUGIN)/plugin.json' || { echo 'Set PLUGIN to a plugin name.'; exit 1; }
	mkdir -p dist
	rm -f 'dist/$(PLUGIN).zip'
	cd plugins && zip -qr '../dist/$(PLUGIN).zip' '$(PLUGIN)'

packages:
	@for plugin in plugins/*; do $(MAKE) package PLUGIN="$$(basename "$$plugin")" || exit; done

release: packages
	@test "$$(git branch --show-current)" = main || { echo 'Run the release from main.'; exit 1; }
	@test -n '$(VERSION)' || { echo 'Set VERSION before the release.'; exit 1; }
	@if git rev-parse --verify --quiet 'refs/tags/v$(VERSION)' >/dev/null; then echo 'Choose a new release version.'; exit 1; fi
	printf '%s\n' '$(VERSION)' > VERSION
	git add --all
	@if ! git diff --cached --quiet; then git commit -m 'Release v$(VERSION)'; fi
	git tag 'v$(VERSION)'
	git push --atomic origin main 'v$(VERSION)'
	gh release create 'v$(VERSION)' dist/*.zip --verify-tag --generate-notes --title 'v$(VERSION)'
