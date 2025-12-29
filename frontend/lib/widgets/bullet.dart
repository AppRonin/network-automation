import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bullet extends StatelessWidget {
  final String text;

  const Bullet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('• ', style: TextStyle(fontSize: 24)),
        Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 14))),
      ],
    );
  }
}
