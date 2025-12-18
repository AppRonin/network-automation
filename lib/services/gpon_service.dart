import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'auth_service.dart';

class GponService {
  static Future<http.StreamedResponse> convert({
    required PlatformFile file,
    required String port,
  }) async {
    final uri = Uri.parse('${AuthService.baseUrl}/gpon-conversor/');

    final request = http.MultipartRequest('POST', uri);

    // 🔐 Auth
    final headers = await AuthService.authHeaders();

    request.headers.addAll(headers);

    // 📄 Fields
    request.fields['port'] = port;

    // 📎 File (WEB)
    request.files.add(
      http.MultipartFile.fromBytes('file', file.bytes!, filename: file.name),
    );

    return await request.send();
  }
}
