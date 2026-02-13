---
name: version-bump
description: Bump the monorepo version across all packages, commit, and tag. Usage: /version-bump 1.13.0
argument-hint: [new-version]
---

# Version Bump for sci_tercen_client Monorepo

Bump all packages from the current version to `$ARGUMENTS`.

## Packages and their pubspec.yaml files

The monorepo has 5 packages. Each has a `version:` field that must be updated:

1. `sci_http_client/pubspec.yaml` — version only (no git ref deps)
2. `sci_base/pubspec.yaml` — version + `ref:` for sci_http_client dependency
3. `sci_tercen_model/pubspec.yaml` — version + `ref:` for sci_base dependency
4. `sci_tercen_client/pubspec.yaml` — version + `ref:` for sci_tercen_model dependency
5. `sci_tercen_context/pubspec.yaml` — version + `ref:` for sci_tercen_client dependency + `ref:` for sci_base dev dependency

## Steps

1. **Read all 5 pubspec.yaml files** to confirm the current version
2. **Update `version:` field** in all 5 files to `$ARGUMENTS`
3. **Update all `ref:` fields** that point to the old version to `$ARGUMENTS`
4. **Switch sci_tercen_context** from path dependency to git dependency:
   - Uncomment the git dependency block and set `ref: $ARGUMENTS`
   - Comment out the `path: ../sci_tercen_client` dependency
5. **Show the diff** with `git diff` for user review
6. **Commit** with message `prepare $ARGUMENTS`
7. **Tag** with `git tag $ARGUMENTS`
8. **Do NOT push** — leave that to the user

## Important notes

- The commented-out path dependencies (e.g. `# path: ../sci_base`) must remain as comments — they are used for local development
- The `tson` dependency ref should NOT be changed (it has its own versioning)
- Old commented-out refs (e.g. `# ref: 1.1.0` for sci_base) should NOT be changed
- Only update active (uncommented) `ref:` values that match the old version
