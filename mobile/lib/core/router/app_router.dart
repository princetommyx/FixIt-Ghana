import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/models/user.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_activity_screen.dart';
import '../../features/customer/presentation/screens/customer_home_screen.dart';
import '../../features/customer/presentation/screens/customer_profile_screen.dart';
import '../../features/customer/presentation/widgets/customer_shell.dart';
import '../../features/professional/presentation/screens/professional_home_screen.dart';
import '../../features/professional/presentation/screens/professional_profile_screen.dart';
import '../../features/professional/presentation/widgets/professional_shell.dart';
import '../../shared/widgets/coming_soon_view.dart';

part 'router_refresh.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authListenable = ref.watch(_authRefreshListenableProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authListenable,
    redirect: (context, state) => _redirect(ref, state),
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            CustomerShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/customer/home', builder: (context, state) => const CustomerHomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/customer/requests',
              builder: (context, state) =>
                  const ComingSoonView(title: 'Requests', icon: Icons.assignment_outlined),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/customer/messages',
              builder: (context, state) =>
                  const ComingSoonView(title: 'Messages', icon: Icons.chat_bubble_outline_rounded),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/customer/activity',
              builder: (context, state) => const CustomerActivityScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/customer/profile',
              builder: (context, state) => const CustomerProfileScreen(),
            ),
          ]),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ProfessionalShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/professional/home',
              builder: (context, state) => const ProfessionalHomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/professional/jobs',
              builder: (context, state) =>
                  const ComingSoonView(title: 'Jobs', icon: Icons.work_outline_rounded),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/professional/messages',
              builder: (context, state) =>
                  const ComingSoonView(title: 'Messages', icon: Icons.chat_bubble_outline_rounded),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/professional/earnings',
              builder: (context, state) =>
                  const ComingSoonView(title: 'Earnings', icon: Icons.payments_outlined),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/professional/profile',
              builder: (context, state) => const ProfessionalProfileScreen(),
            ),
          ]),
        ],
      ),
    ],
  );
});

String? _redirect(Ref ref, GoRouterState state) {
  final authState = ref.read(authControllerProvider);
  final location = state.matchedLocation;

  const authFlowRoutes = ['/splash', '/onboarding', '/login', '/register', '/role-selection'];
  final onAuthFlowRoute = authFlowRoutes.contains(location);

  // Splash owns the initial "where do we send a cold start" decision
  // (restore session, or send to onboarding/login) — see SplashScreen.
  if (location == '/splash') return null;

  return authState.when(
    loading: () => null,
    error: (_, __) => onAuthFlowRoute ? null : '/login',
    data: (user) {
      if (user == null) {
        return onAuthFlowRoute ? null : '/login';
      }

      final home = user.role == UserRole.professional ? '/professional/home' : '/customer/home';

      if (onAuthFlowRoute) return home;

      final inCustomerArea = location.startsWith('/customer');
      final inProfessionalArea = location.startsWith('/professional');
      final wrongArea = (user.role == UserRole.professional && inCustomerArea) ||
          (user.role != UserRole.professional && inProfessionalArea);

      return wrongArea ? home : null;
    },
  );
}
