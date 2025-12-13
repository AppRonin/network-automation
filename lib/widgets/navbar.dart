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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 21),
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
    );
  }
}
