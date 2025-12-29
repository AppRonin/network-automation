import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/widgets/login_button.dart';
import 'package:network_automation/widgets/navbar.dart';
import 'package:network_automation/widgets/navlink.dart';

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

    void handleSelection(index) {
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
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // 🔹 SCROLLABLE AREA
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Text(
                        "IPS",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  Navlink(
                    name: "Home",
                    index: 1,
                    activeIndex: activeIndex,
                    onSelection: handleSelection,
                  ),

                  ExpansionTile(
                    title: Text(
                      "Automações",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    showTrailingIcon: false,
                    children: [
                      ListTile(
                        title: const Text("Conversor Gpon"),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/conversor');
                        },
                      ),
                    ],
                  ),

                  Navlink(
                    name: "Sobre",
                    index: 3,
                    activeIndex: activeIndex,
                    onSelection: handleSelection,
                  ),
                ],
              ),
            ),

            // 🔹 FIXED BOTTOM AREA
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: LoginButton(
                index: 4,
                activeIndex: activeIndex,
                onSelection: handleSelection,
              ),
            ),
          ],
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Navbar(activeIndex: activeIndex, onSelection: handleSelection),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 80, // navbar height
                ),
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
