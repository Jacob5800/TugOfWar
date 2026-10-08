# Repository guidance

- Keep the README accurate when plugin behavior, settings, commands, or build steps change.
- Run `dotnet build .\TugOfWar.csproj` and `dotnet run --project .\tests\TugOfWarChecks.csproj` after code changes.
- Do not commit `bin`, `obj`, or `dist` build output.
- Party chat announcements must remain opt-in and disabled by default.
- Do not describe this source repository as an installable Dalamud feed. No release or plugin-repository pipeline is configured yet.
