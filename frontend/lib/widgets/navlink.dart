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

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onSelection(index),
        child: Container(
          width: !mobile ? null : double.infinity,
          decoration: BoxDecoration(
            color: (index == activeIndex)
                ? Colors.grey[100]
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: !mobile ? 8 : 16,
          ),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: !mobile ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
