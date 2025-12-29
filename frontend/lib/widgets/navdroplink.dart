import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDroplink extends StatelessWidget {
  final String name;
  final String description;
  final int index;
  final int activeIndex;
  final Function onSelection;

  const NavDroplink({
    super.key,
    required this.name,
    required this.description,
    required this.index,
    required this.activeIndex,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onSelection(index);
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            color: (index == activeIndex)
                ? Colors.grey[100]
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
