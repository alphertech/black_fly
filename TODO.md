# APK Build Progress - BLACKBOXAI (Approved Plan Breakdown)

## Current Status
- [x] Plan approved and TODO.md created
- [x] pubspec.yaml reviewed (deps OK, some outdated but compatible)
- [x] flutter pub get **COMPLETE** (success after ~2min, 38 outdated packages noted)
- [x] flutter analyze **COMPLETE** (7 issues: 1 unused field, 3 use_build_context_synchronously, 2 deprecated Radio, 1 expected_token syntax)
- [ ] Fix 7 lint errors (detailed below)
- [ ] User fixes Android cmdline-tools + flutter doctor --android-licenses
- [ ] flutter test
- [ ] flutter build apk --release
- [ ] APK ready at build/app/outputs/flutter-apk/app-release.apk

## Lint Fixes Plan (Step 1/4 - Code Edits)
1. lib/providers/server_provider.dart: Remove unused _favoriteIds List<String>
2. lib/screens/auth_screen.dart: Fix syntax error line ~246 (missing ')'), fix 3 use_build_context_synchronously (use if(mounted) before context calls post-async)
3. lib/screens/servers_screen.dart: Replace deprecated Radio with RadioGroup (Flutter 3.32+)
4. Re-run flutter analyze → 0 issues

**Next:** Will edit files after reading them fully. Then mark [x], run tests/build.

## Environment Fix (User Action Required)
flutter doctor shows missing cmdline-tools. After fixes:
```
sdkmanager "cmdline-tools;latest"  # or manual download/unzip to %ANDROID_HOME%/cmdline-tools/latest/
flutter doctor --android-licenses
```

## Post-Build
APK will be installable on Android devices (minSdk check pending). VPN mock-only (no real tunnel yet).

Updated after each step.

