# Android Release Signing

1. Create a release keystore:
   ```bash
   keytool -genkey -v -keystore anufit-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias anufit
   ```
2. Copy `android/key.properties.example` to `android/key.properties` and fill in values.
3. Place the keystore at `android/keystore/anufit-release.jks`.
4. Build release:
   ```bash
   ./scripts/build.sh production appbundle
   ```

See also [store checklist](../compliance/store-checklist.md).

Never commit `key.properties` or `.jks` files to version control.
