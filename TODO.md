# SEYTRONS VPN App - Complete Functional APK Plan & Progress - BLACKBOXAI

## Current Status
- ✅ Plan approved by user
- Initial `flutter analyze`: ~39-54 lint errors (unused imports, deprecations, refs)
- [ ] No android/ folder: Can't build APK yet
- VPN: Mock only - no real tunnel

## TODO Steps (Execute Sequentially)

### Step 1: Dependencies & Platforms (Critical for Build/VPN) ✅ COMPLETE
- ✅ Update pubspec.yaml (VPN deps ready, wireguard commented - not on pub.dev)
- ✅ `flutter pub get` (success)
- ✅ `flutter create . --platforms android`
- ✅ `flutter doctor -v` (Flutter OK, Android cmdline-tools missing - user fix)

### Step 2: Fix All 39+ Errors/Lints (Compilation Clean)
- [ ] Run `flutter analyze` → Identify exact issues
- [ ] Edit providers: lib/providers/vpn_provider.dart, server_provider.dart (add missing methods like getFilteredServers, getters)
- [ ] Fix screens: dashboard_screen.dart, servers_screen.dart (variable refs, provider calls)
- [ ] Widgets: location_card.dart, side_menu.dart (Icons.crown → FontAwesome, deprecations)
- [ ] test/widget_test.dart: Update 'MyApp' to 'SEYTRONSApp'
- [ ] Remove unused imports, add const
- [ ] Re-run `flutter analyze` → 0 errors

### Step 3: Real VPN Functionality
... (rest of steps unchanged)

### Step 2: Fix All 39+ Errors/Lints (Compilation Clean)

- [ ] Run `flutter analyze` → Identify exact issues
- [ ] Edit providers: lib/providers/vpn_provider.dart, server_provider.dart (add missing methods like getFilteredServers, getters)
- [ ] Fix screens: dashboard_screen.dart, servers_screen.dart (variable refs, provider calls)
- [ ] Widgets: location_card.dart, side_menu.dart (Icons.crown → FontAwesome, deprecations)
- [ ] test/widget_test.dart: Update 'MyApp' to 'SEYTRONSApp'
- [ ] Remove unused imports, add const
- [ ] Re-run `flutter analyze` → 0 errors

### Step 3: Real VPN Functionality

- [ ] Update lib/services/vpn_service.dart: Integrate wireguard_flutter_android - generate mock WG configs for servers (private_key, endpoint from ServerModel), Vpn.connect(config), handle onStatusChanged for state/speed/IP
- [ ] Add permission_handler: request VPN/foreground/overlay perms on connect
- [ ] Update lib/providers/vpn_provider.dart: Use real service, expose actual metrics (remove mocks)
- [ ] Constants: Add mock WG configs per server

### Step 4: Android Config

- [ ] Edit android/app/src/main/AndroidManifest.xml: `<uses-permission android:name=\"android.permission.BIND_VPN_SERVICE\" />`, `<uses-permission android:name=\"android.permission.FOREGROUND_SERVICE\" />`, service declaration
- [ ] android/app/build.gradle: minSdkVersion 24+, proguard false for VPN
- [ ] Test: `flutter run -d android`

### Step 5: Feature Polish & Auth/Mocks

- [ ] AuthProvider: Implement shared_preferences login/register
- [ ] ServerProvider: Load mock servers with WG data, filter/fav
- [ ] Dashboard/Stats: Real network stats via network_info_plus + VPN state
- [ ] Settings: Auto-connect logic
- [ ] Onboarding/Profile/Subscription: Mock flows

### Step 6: Test & Build

- [ ] `flutter test`
- [ ] `flutter analyze --fatal-warnings` (clean)
- [ ] `flutter build apk --release`
- [ ] Verify APK installs/runs, VPN connects (emulator/device)

## Progress Tracking

Update [x] on complete. Next command after each step.
