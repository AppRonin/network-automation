import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:network_automation/widgets/navbar.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int activeIndex = 1;
    if (location.contains('/auto')) activeIndex = 2;
    if (location.contains('/sobre')) activeIndex = 3;
    if (location.contains('/login')) activeIndex = 4;
    if (location.contains('/conversor')) activeIndex = 20;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Navbar(
            activeIndex: activeIndex,
            onSelection: (index) {
              switch (index) {
                case 1:
                  context.go('/home');
                  break;
                case 2:
                  context.go('/auto');
                  break;
                case 3:
                  context.go('/sobre');
                  break;
                case 4:
                  context.go('/login');
                  break;
                case 20:
                  context.go('/conversor');
                  break;
              }
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
