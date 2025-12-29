import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Bem Vindo a IP Station',
              textStyle: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              speed: const Duration(milliseconds: 120),
            ),
          ],
          totalRepeatCount: 1,
        ),
      ),
    );
  }
}
