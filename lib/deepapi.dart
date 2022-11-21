import 'dart:convert';
import 'package:http/http.dart' as http;

Future exportTaskrun(request, authKey) async {
  final header = {
    'Authorization': 'Bearer ${authKey ?? ''}',
    'Content-Type': 'application/json',
  };
  final url = Uri.https('data.deepnatural.ai', 'export_taskrun/');
  final response =
      await http.post(url, headers: header, body: jsonEncode(request));

  return response;
}

Future get({endpoint, path, headers}) async {
  var url = Uri.https(
    endpoint = endpoint,
    path = path,
  );

  var response = await http.get(url, headers: headers);
  List successStatusCode = [200];
  if (!successStatusCode.contains(response.statusCode)) {
    throw Exception('Request failed');
  }
  return jsonDecode(utf8.decode(response.bodyBytes));
}
