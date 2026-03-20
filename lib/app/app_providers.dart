/// Legacy provider bridge kept temporarily for compatibility.
///
/// The app now boots with Riverpod-only in `main.dart`.
@Deprecated('Use Riverpod ProviderScope and feature riverpod_providers instead.')
List<Object> buildAppProviders() {
  return const [];
}

