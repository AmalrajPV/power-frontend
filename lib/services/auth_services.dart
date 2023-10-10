import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:power_monitor/models/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String apiUrl = '$baseUrl/auth';
  final _secureStorage = const FlutterSecureStorage();

  Future<User?> register(String username, String email, String consumerId,
      String productId, String password) async {
    final Map<String, String> requestData = {
      'userName': username,
      'email': email,
      'consumerId': consumerId,
      'productId': productId,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse('$apiUrl/register'),
      body: jsonEncode(requestData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse['user']);
    } else {
      return null;
    }
  }

  Future<bool> login(String email, String password) async {
    final Map<String, String> requestData = {
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse('$apiUrl/login'),
      body: jsonEncode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['access_token'];
      if (token != null) {
        await _secureStorage.write(key: 'access_token', value: token);
        return true;
      }
    }

    return false;
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await _secureStorage.delete(key: 'access_token');
  }

  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token;
  }

  Future<bool> isLoggedIn() async {
    return await _secureStorage.read(key: 'access_token') != null;
  }
}
