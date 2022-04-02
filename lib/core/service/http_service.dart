import 'dart:convert';

import 'package:central_de_clientes/shared/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<dynamic> get(String url) async {
    final result = await http.get(url.toUri);
    return jsonDecode(result.body);
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    final result = await http.post(
      url.toUri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = jsonDecode(result.body);
    return data;
  }

  Future<dynamic> patch(String url, {Map<String, dynamic>? body}) async {
    final result = await http.patch(
      url.toUri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return jsonDecode(result.body);
  }

  Future<int> delete(String url, {Map<String, dynamic>? body}) async {
    final result = await http.delete(
      url.toUri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return result.statusCode;
  }
}
