import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navlink extends StatelessWidget {
  final String name;
  final int index;
  final int activeIndex;
  final Function onSelection;

  const Navlink({
    super.key,
    required this.name,
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
            color: (index == activeIndex)
                ? Colors.grey[100]
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            name,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
