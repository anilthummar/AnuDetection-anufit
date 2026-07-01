# Store Listing Assets

Prepare the following before Play Store / App Store submission:

| Asset | Size | Notes |
|-------|------|-------|
| App icon | 512×512 PNG | Play Store feature graphic optional 1024×500 |
| Screenshots | Phone + tablet | Dashboard, goals, statistics, weight, water |
| Short description | 80 chars | Offline step tracker with health sync |
| Full description | 4000 chars | Highlight offline-first, privacy, widgets |
| Privacy policy URL | — | Host via [compliance guide](../compliance/privacy-policy-hosting.md) — must match `LegalConfig.privacyPolicyUrl` |

## iOS Widget Extension

1. Open `ios/Runner.xcworkspace` in Xcode
2. Add Widget Extension target named `AnufitWidget`
3. Set App Group: `group.com.anudetection.anufit`
4. Configure lock screen widget families in WidgetKit

See [home_widget](https://pub.dev/packages/home_widget) for platform setup details.
