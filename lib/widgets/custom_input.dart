import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final TextEditingController controller;

  const CustomInput({
    super.key,
    required this.label,
    required this.placeholder,
    required this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ External label
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),

        SizedBox(
          height: 38,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: GoogleFonts.inter(fontSize: 14),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),

              contentPadding: const EdgeInsets.symmetric(horizontal: 12),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
