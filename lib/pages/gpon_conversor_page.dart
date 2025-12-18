import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/services/gpon_service.dart';
import 'package:network_automation/widgets/custom_input.dart';
import 'package:network_automation/widgets/custom_input_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:network_automation/widgets/progress_bar.dart';

class GponConversorPage extends StatefulWidget {
  const GponConversorPage({super.key});

  @override
  State<GponConversorPage> createState() => _GponConversorPageState();
}

class _GponConversorPageState extends State<GponConversorPage> {
  final portController = TextEditingController();
  PlatformFile? file;
  String? error;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = file == null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: Container(
          width: 500,
          height: 325,
          padding: EdgeInsets.only(left: 24, right: 24, top: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.1,
                ), // Shadow color with opacity
                offset: Offset(0, 4), // X, Y offset
                blurRadius: 6, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Conversor Gpon",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              CustomInputFile(
                label: "Arquivo:",
                placeholder: "Escolha um arquivo.txt",
                file: file,
                onPickFile: pickFile,
              ),
              SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomInput(
                      label: "Porta:",
                      placeholder: "EX: 1/1/1",
                      isPassword: false,
                      controller: portController,
                    ),
                  ),
                  SizedBox(width: 16),

                  // Submit Button
                  MouseRegion(
                    cursor: isDisabled
                        ? SystemMouseCursors.forbidden
                        : SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: isDisabled
                          ? null
                          : () async {
                              final response = await GponService.convert(
                                file: file!,
                                port: portController.text.trim(),
                              );

                              final bodyString = await response.stream
                                  .bytesToString();
                              final data = jsonDecode(bodyString);

                              if (response.statusCode == 200) {
                                setState(() {
                                  error = null;
                                });
                              } else {
                                setState(() {
                                  error = data['error'];
                                });
                              }
                            },
                      child: Opacity(
                        opacity: isDisabled ? 0.5 : 1,
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: isDisabled ? Colors.grey : Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Center(
                            child: Text(
                              "Converter",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                error ?? '',
                style: GoogleFonts.inter(fontSize: 14, color: Colors.red),
              ),

              SizedBox(height: 24),

              SimpleProgressBar(progress: 0.65),
            ],
          ),
        ),
      ),
    );
  }
}
