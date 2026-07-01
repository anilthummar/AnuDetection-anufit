# Privacy policy hosting

Google Play and Apple App Store require a **public HTTPS URL** for your privacy policy. The in-app policy alone is not sufficient.

## Source of truth

| File | Role |
|------|------|
| `assets/legal/privacy_policy.html` | Shipped inside the app (WebView) |
| `lib/core/constants/legal_config.dart` | `privacyPolicyUrl` and `supportEmail` for store listings |
| `docs/compliance/hosting/privacy/index.html` | Deploy to your website |

Keep all three aligned when you change contact details or policy text.

## 1. Update contact details

Edit `lib/core/constants/legal_config.dart`:

```dart
static const String supportEmail = 'support@yourdomain.com';
static const String privacyPolicyUrl = 'https://yourdomain.com/privacy';
```

Update the same email and URL in `assets/legal/privacy_policy.html` (section 15).

## 2. Sync deployable HTML

```bash
chmod +x scripts/sync_privacy_policy.sh
./scripts/sync_privacy_policy.sh
```

This copies the in-app HTML to `docs/compliance/hosting/privacy/index.html` and removes the developer-only footer line.

## 3. Choose a host

The target URL must match `LegalConfig.privacyPolicyUrl` exactly (including trailing slash policy).

| Host | URL shape | Steps |
|------|-----------|-------|
| **Google Sites** | `https://sites.google.com/view/your-site/privacy` | Free, no code — see [Google Sites guide](#google-sites-recommended-for-quick-play-setup) below |
| **GitHub Pages** | `https://user.github.io/repo/privacy/` | Push `docs/compliance/hosting/` to `gh-pages` branch or use `/docs` folder setting |
| **Cloudflare Pages** | `https://yourdomain.com/privacy` | New project → upload `hosting/` folder → set custom domain |
| **Netlify** | `https://yourdomain.com/privacy` | Drag `hosting/` folder to Netlify Drop or connect repo |
| **Firebase Hosting** | `https://yourdomain.com/privacy` | `firebase init hosting` → publish `hosting/` as `public` |
| **S3 + CloudFront** | `https://yourdomain.com/privacy` | Upload `privacy/index.html` with `text/html` content type |

### Google Sites (recommended for quick Play setup)

No hosting account or HTML upload needed. Google Play accepts a public `sites.google.com` HTTPS URL.

**Copy-paste content:** [hosting/google-sites-privacy-policy-copy.md](./hosting/google-sites-privacy-policy-copy.md)

1. Open [Google Sites](https://sites.google.com) → **Blank** (or use template).
2. Site name (top left): e.g. **AnuDetection** or **Step Counter - Pedometer**.
3. **Pages** (right panel) → **+** → name the page **Privacy** (URL slug becomes `/privacy`).
4. On the page:
   - Insert → **Text box** → paste content from `google-sites-privacy-policy-copy.md`.
   - For each `##` section in that file, use **Heading** style in Sites (Format → Heading).
   - For bullet lists, use the Sites bullet button.
   - In **15. Contact Us**, link email: select text → Insert link → `mailto:support@anudetection.com`.
5. **Publish** (top right):
   - Who can view: **Anyone on the web**
   - Web address: choose a short name, e.g. `anudetection` → live URL:
     `https://sites.google.com/view/anudetection/privacy`
6. **Update the app** — set `privacyPolicyUrl` in `legal_config.dart` to your **exact** published URL (copy from browser after publish).
7. Update section 15 in `assets/legal/privacy_policy.html` with the same URL, then run `./scripts/sync_privacy_policy.sh`.

**Optional — custom domain** (`anudetection.com/privacy`):

- Google Sites → **Settings** → **Custom domains** → map `anudetection.com` (requires domain DNS access).
- If you use a custom domain, `privacyPolicyUrl` must be `https://anudetection.com/privacy` (or `/privacy/` — pick one and use it everywhere).

**Verify:**

```bash
curl -fsSL -o /dev/null -w "%{http_code}\n" "https://sites.google.com/view/anudetection/privacy"
```

### GitHub Pages (quickest)

1. Create a repo or use an existing org site repo.
2. Copy contents of `docs/compliance/hosting/` to the site root (so `privacy/index.html` exists).
3. Enable GitHub Pages (Settings → Pages → branch `main`, folder `/`).
4. Optional: add custom domain `anudetection.com` in Pages settings.
5. Verify: `curl -I https://anudetection.com/privacy/` returns `200` and `content-type: text/html`.

### Cloudflare Pages (recommended for custom domain)

1. Dashboard → Workers & Pages → Create → Pages → Upload assets.
2. Upload the `docs/compliance/hosting` folder.
3. Attach domain `anudetection.com`.
4. Add redirect rule if needed: `/privacy` → `/privacy/` (or serve `index.html` at `/privacy`).

## 4. Verify before store submit

```bash
# Replace with your live URL
URL="https://anudetection.com/privacy"

curl -fsSL -o /dev/null -w "%{http_code}\n" "$URL"
curl -fsSL "$URL" | head -20
```

Checklist:

- [ ] URL loads over **HTTPS** (not HTTP)
- [ ] Returns **200** without login
- [ ] Content matches in-app policy (contact email, last updated date)
- [ ] Same URL entered in **Play Console** → App content → Privacy policy
- [ ] Same URL entered in **App Store Connect** → App Privacy → Privacy Policy URL
- [ ] `LegalConfig.privacyPolicyUrl` in the app matches exactly

## 5. Store console fields

| Console | Field | Value |
|---------|-------|-------|
| Google Play | Privacy policy URL | `LegalConfig.privacyPolicyUrl` |
| Google Play | Contact email | `LegalConfig.supportEmail` |
| App Store Connect | Privacy Policy URL | Same HTTPS URL |
| App Store Connect | Support URL / email | Same support email |

## 6. When you update the policy

1. Edit `assets/legal/privacy_policy.html` and bump **Last updated**.
2. Run `./scripts/sync_privacy_policy.sh`.
3. Redeploy `docs/compliance/hosting/` to your host.
4. Ship an app update if in-app copy changed materially.
5. Update Data Safety / App Privacy labels if collection practices changed.
