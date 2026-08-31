part of 'app_router.dart';

/// Bridges [authControllerProvider] changes into a [Listenable] so GoRouter
/// re-evaluates `redirect` whenever the signed-in user changes.
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(this._ref) {
    _subscription = _ref.listen<AsyncValue<User?>>(
      authControllerProvider,
      (previous, next) => notifyListeners(),
    );
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<User?>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

final _authRefreshListenableProvider = Provider<_AuthRefreshListenable>((ref) {
  final listenable = _AuthRefreshListenable(ref);
  ref.onDispose(listenable.dispose);
  return listenable;
});
