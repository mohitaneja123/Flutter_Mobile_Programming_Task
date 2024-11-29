import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserRepository {
  final String baseUrl;

  UserRepository({this.baseUrl = 'https://jsonplaceholder.typicode.com'});

  Future<List<User>> fetchUsers() async {
      final uri = Uri.parse('$baseUrl/users');
      final response = await http.get(uri);
      try {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
