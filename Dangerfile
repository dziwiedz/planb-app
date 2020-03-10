# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
fail("fit left in tests") if `grep -r fit specs/ `.length > 1



swiftlint.config_file = 'Tools/Swiftlint/config.yml'
swiftlint.lint_files
todoist.warn_for_todos

xcov.report(
	project: "PlanB.xcodeproj",
	minimum_coverage_percentage: 0.0
)