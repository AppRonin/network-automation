import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:network_automation/pages/gpon_conversor_page.dart';

import 'app_shell.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/login_page.dart';

import 'package:network_automation/services/auth_service.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/home',
      redirect: (context, state) async {
        final loggedIn = await AuthService.isLoggedIn();
        final isLogin = state.uri.path == '/login';
        final isConversor = state.uri.path == '/conversor';

        // Protect ONLY /conversor
        if (isConversor && !loggedIn) {
          return '/login';
        }

        // Prevent logged user from seeing login page
        if (loggedIn && isLogin) {
          return '/home';
        }

        return null;
      },

      routes: [
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: '/auto',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: '/sobre',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AboutPage()),
            ),
            GoRoute(
              path: '/login',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: LoginPage()),
            ),
            GoRoute(
              path: '/conversor',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: GponConversorPage()),
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
