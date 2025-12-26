import 'dart:convert';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/services/gpon_service.dart';
import 'package:network_automation/widgets/custom_input.dart';
import 'package:network_automation/widgets/custom_input_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:network_automation/widgets/progress_bar.dart';
import 'package:http/http.dart' as http;

class GponConversorPage extends StatefulWidget {
  const GponConversorPage({super.key});

  @override
  State<GponConversorPage> createState() => _GponConversorPageState();
}

class _GponConversorPageState extends State<GponConversorPage> {
  final portController = TextEditingController();
  PlatformFile? file;
  String? error;

  Map<String, dynamic> result = {};
  double progress = 0;
  bool isLoading = false;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = result.files.first;
      });
    }
  }

  Future<Map<String, dynamic>> getProgress(String taskID) async {
    final url = Uri.parse('http://localhost:8000/api/v1/progress/$taskID');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load progress');
    }
  }

  Future<Map<String, dynamic>> runTask(String taskID) async {
    int attempts = 0;
    const maxAttempts = 10;

    while (progress < 100 && attempts < maxAttempts) {
      try {
        var taskProgress = await getProgress(taskID);
        setState(() {
          progress = double.parse(taskProgress["progress"].toString());
        });

        if (taskProgress["result"] != null) {
          result = taskProgress["result"];
          break;
        }
      } catch (e) {
        debugPrint("Error: $e");
      }

      attempts++;
      await Future.delayed(const Duration(seconds: 1));
    }

    return result;
  }

  Future<void> exportTxtWithFileSaver({
    required String content,
    String filename = 'export',
  }) async {
    final bytes = Uint8List.fromList(content.codeUnits);

    await FileSaver.instance.saveFile(
      name: filename,
      bytes: bytes,
      fileExtension: 'txt',
      mimeType: MimeType.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = file == null || isLoading;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 64),
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
                                try {
                                  setState(() {
                                    isLoading = true;
                                    error = null;
                                    progress = 0;
                                  });

                                  final response = await GponService.startTask(
                                    file: file!,
                                    port: portController.text.trim(),
                                  );

                                  final bodyString = await response.stream
                                      .bytesToString();
                                  final data = jsonDecode(bodyString);

                                  if (response.statusCode == 200) {
                                    final taskID = data["task_id"];
                                    result = await runTask(taskID);

                                    if (result.isNotEmpty) {
                                      await exportTxtWithFileSaver(
                                        filename: "resultado",
                                        content: result["template"],
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      error = data['error'];
                                    });
                                  }
                                } catch (e) {
                                  debugPrint(e.toString());
                                } finally {
                                  setState(() {
                                    isLoading = false;
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

                SimpleProgressBar(progress: progress),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
