# Repository guidance

- Keep the README accurate when plugin behavior, settings, commands, or build steps change.
- Run `dotnet build .\TugOfWar.csproj` and `dotnet run --project .\tests\TugOfWarChecks.csproj` after code changes.
- Do not commit `bin`, `obj`, or `dist` build output.
- Party chat announcements must remain opt-in and disabled by default.
- Keep the custom Dalamud repository feed and tagged-release workflow operational. The workflow generates `pluginmaster.json` from the built manifest and attaches it with `latest.zip` to each GitHub release.
- For releases, keep the four-part `AssemblyVersion` in `TugOfWar.json` aligned with the `v` tag (for example, `v0.1.0.0`). Run the documented build and checks before tagging; do not commit `bin`, `obj`, or `dist` outputs.
- Keep the README's custom repository URL and install steps accurate.
