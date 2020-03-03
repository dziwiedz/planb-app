CARTHAGE_FRAMEWORKS=ls Carthage/Build/iOS/*.framework | grep "\.framework" | cut -d "/" -f 4 | cut -d "." -f 1 | xargs -I '{}'
CARTHAGE_ARCHIVES=ls PreBuiltFrameworks/*.zip | grep "\.zip" | cut -d "/" -f 2 | cut -d "." -f 1 | xargs -I '{}'

bootstrap: install-git-lfs generate blade carthage_extract
	@brew list xcodegen || brew install xcodegen
	@brew tap jondot/tap
	@brew install blade
	@brew install bundler
	@bundler install --path vendor/bundler/
	@bundle install
	@bundle exec pod install
install-git-lfs:
	@brew list git git-lfs || brew install git git-lfs 
	@git lfs install
generate:
	@xcodegen generate
blade:
	@blade --verbose
carthage_clean: ## clean up all Carthage directories
	@rm -rf Carthage
carthage_update: ## update carthage packages
	@carthage update --platform iOS --no-use-binaries

carthage_archive: carthage_update ## update and archive carthage packages
	@rm -rf PreBuiltFrameworks/*.zip
	$(CARTHAGE_FRAMEWORKS) carthage archive '{}' --output PreBuiltFrameworks/

carthage_track: carthage_archive ## track and commit carthage frameworks
	git lfs track PreBuiltFrameworks/*.zip
	git add .gitattributes
	git commit -m "Tracking Prebuilt Frameworks"
	git add PreBuiltFrameworks/*.zip
	git commit -m "Adding Prebuild Framworks"

carthage_extract: carthage_clean ## extract from carthage archives
	$(CARTHAGE_ARCHIVES) unzip PreBuiltFrameworks/'{}'.framework.zip

carthage_copy: ## copy carthage frameworks
	$(CARTHAGE_FRAMEWORKS) env SCRIPT_INPUT_FILE_0=Carthage/build/iOS/'{}'.framework SCRIPT_INPUT_FILE_COUNT=1 carthage copy-frameworks