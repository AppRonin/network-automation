import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/widgets/login_button.dart';
import 'package:network_automation/widgets/navlink.dart';
import 'package:network_automation/widgets/navdrop.dart';

class Navbar extends StatelessWidget {
  final int activeIndex;
  final void Function(int) onSelection;

  const Navbar({
    super.key,
    required this.activeIndex,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const MobileNavbar();
        }

        return DesktopNavbar(
          activeIndex: activeIndex,
          onSelection: onSelection,
        );
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  final int activeIndex;
  final void Function(int) onSelection;

  const DesktopNavbar({
    super.key,
    required this.activeIndex,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 64),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Center(
        child: SizedBox(
          width: 1200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "IPS",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Row(
                children: [
                  Navlink(
                    name: "Home",
                    index: 1,
                    activeIndex: activeIndex,
                    onSelection: onSelection,
                  ),

                  Navdrop(
                    name: "Automações",
                    index: 2,
                    activeIndex: activeIndex,
                    onSelection: onSelection,
                  ),

                  Navlink(
                    name: "Sobre",
                    index: 3,
                    activeIndex: activeIndex,
                    onSelection: onSelection,
                  ),
                ],
              ),

              LoginButton(
                index: 4,
                activeIndex: activeIndex,
                onSelection: onSelection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  const MobileNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "IPS",
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
