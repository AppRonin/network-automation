import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:network_automation/pages/gpon_conversor_page.dart';

import 'app_shell.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: '/auto',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: '/sobre',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: AboutPage()),
            ),
            GoRoute(
              path: '/login',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: LoginPage()),
            ),
            GoRoute(
              path: '/conversor',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: GponConversorPage()),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
