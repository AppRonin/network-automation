import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/widgets/navdroplink.dart';
import 'package:popover/popover.dart';

class Navdrop extends StatelessWidget {
  final String name;
  final int index;
  final int activeIndex;
  final Function onSelection;

  const Navdrop({
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
        onTap: () => showPopover(
          context: context,
          width: 320,
          barrierColor: Colors.transparent,
          arrowHeight: 0,
          arrowWidth: 0,
          contentDyOffset: 8,
          bodyBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavDroplink(
                  name: 'Conversor Gpon',
                  description: 'Conversor entre modelos',
                  index: 20,
                  activeIndex: activeIndex,
                  onSelection: onSelection,
                ),
              ],
            ),
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            color: (activeIndex >= 20) ? Colors.grey[100] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
