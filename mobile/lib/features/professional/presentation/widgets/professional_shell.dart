import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom nav per spec section 6: Home • Jobs • Messages • Earnings • Profile
class ProfessionalShell extends StatelessWidget {
  const ProfessionalShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.work_outline_rounded, activeIcon: Icons.work_rounded, label: 'Jobs'),
    (icon: Icons.chat_bubble_outline_rounded, activeIcon: Icons.chat_bubble_rounded, label: 'Messages'),
    (icon: Icons.payments_outlined, activeIcon: Icons.payments_rounded, label: 'Earnings'),
    (icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(
              icon: Icon(tab.icon),
              activeIcon: Icon(tab.activeIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}
