abstract class ServiceEndpoints {
  static const String _baseUrl = 'https://forassetapi.herokuapp.com';

  static String get clients => '$_baseUrl/people';

  static String editClient(int id) => '$clients/$id}';
}