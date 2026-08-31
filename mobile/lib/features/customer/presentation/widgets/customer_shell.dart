import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom nav per spec section 6: Home • Requests • Messages • Activity • Profile
class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.assignment_outlined, activeIcon: Icons.assignment_rounded, label: 'Requests'),
    (icon: Icons.chat_bubble_outline_rounded, activeIcon: Icons.chat_bubble_rounded, label: 'Messages'),
    (icon: Icons.history_rounded, activeIcon: Icons.history_rounded, label: 'Activity'),
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
