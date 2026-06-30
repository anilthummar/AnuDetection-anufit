/// Store-release feature toggles.
///
/// Disable incomplete or planned surfaces until they ship in a later version.
abstract final class ReleaseFeatures {
  /// Google Drive / iCloud sync (UI stub only).
  static const bool cloudSync = false;

  /// Hindi and Gujarati localizations (partial translations).
  static const bool partialLocales = false;
}
