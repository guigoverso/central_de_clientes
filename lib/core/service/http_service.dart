import 'dart:convert';

import 'package:central_de_clientes/shared/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

class HttpService {

  Future<dynamic> get(String url) async {
    final result = await http.get(url.toUri);
    return jsonDecode(result.body);
  }

  Future<Map<int, dynamic>> post(String url, {Map<String, dynamic>? body}) async {
    final result = await http.post(url.toUri, body: body);
    final data = jsonDecode(result.body);
    return {result.statusCode: data};
  }

  Future<int> patch(String url, {Map<String, dynamic>? body}) async {
    final result = await http.patch(url.toUri, body: body);
    return result.statusCode;
  }

  Future<int> delete(String url, {Map<String, dynamic>? body}) async {
    final result = await http.delete(url.toUri, body: body);
    return result.statusCode;
  }

}