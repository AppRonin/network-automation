import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class LoginButton extends StatelessWidget {
  final int index;
  final int activeIndex;
  final Function onSelection;

  const LoginButton({
    super.key,
    required this.index,
    required this.activeIndex,
    required this.onSelection,
  });

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (context, snapshot) {
        final loggedIn = snapshot.data ?? false;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              if (loggedIn) {
                // LOGOUT
                await AuthService.logout();
                context.go('/login');
              } else {
                // LOGIN
                context.go('/login');
              }
            },
            child: Container(
              width: !mobile ? null : double.infinity,
              margin: !mobile
                  ? const EdgeInsets.symmetric(horizontal: 0)
                  : const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: loggedIn ? Colors.red : Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                loggedIn ? "Sair" : "Entrar",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: !mobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
