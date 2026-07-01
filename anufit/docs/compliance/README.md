# Store compliance

Checklists and hosting guides for Google Play and Apple App Store submission.

| Document | Purpose |
|----------|---------|
| [store-checklist.md](./store-checklist.md) | Internal → closed → production release gates |
| [privacy-policy-hosting.md](./privacy-policy-hosting.md) | Host the public privacy policy URL |
| [hosting/privacy/](./hosting/privacy/) | Ready-to-deploy static HTML (`index.html`) |

**Canonical in-app policy:** `assets/legal/privacy_policy.html`  
**App constants:** `lib/core/constants/legal_config.dart`

After editing the policy HTML, run:

```bash
./scripts/sync_privacy_policy.sh
```
