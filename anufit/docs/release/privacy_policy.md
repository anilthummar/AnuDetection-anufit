# Privacy policy

**Canonical source (in-app):** `assets/legal/privacy_policy.html`  
**App constants:** `lib/core/constants/legal_config.dart`  
**Public hosting:** [compliance/privacy-policy-hosting.md](../compliance/privacy-policy-hosting.md)

## Summary

Step Counter - Pedometer is offline-first. Data stays on the device unless the user exports, shares, or connects Apple Health / Health Connect.

## What we collect (on device)

- Steps, distance, calories, walking time, activity timeline
- Profile fields the user enters (age, height, weight, goals)
- Weight and water logs entered in the app
- Optional sync: steps, distance, active calories via Health Connect / Apple Health

## What we do not collect

- No account or login
- No GPS / location
- No ads or third-party analytics SDKs (current production build)
- No sale of personal data

## User rights

- Export via Backup & Restore
- Disconnect health platforms in Settings
- Delete data in-app or by uninstalling

## Contact

See `LegalConfig` in `lib/core/constants/legal_config.dart` and section 15 of the HTML policy.

## Maintenance

1. Edit `assets/legal/privacy_policy.html`
2. Run `./scripts/sync_privacy_policy.sh`
3. Redeploy `docs/compliance/hosting/privacy/` to your website
4. Update store console URLs if the public URL changes
