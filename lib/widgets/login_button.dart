import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () => onSelection(index),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "Entrar",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
