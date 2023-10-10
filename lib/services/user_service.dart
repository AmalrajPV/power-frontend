import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:power_monitor/models/user_model.dart';
import 'package:power_monitor/services/auth_services.dart';
import '../constants.dart';

class UserService {
  static const String apiUrl = '$baseUrl/users';

  Future<UserProfile> myProfile() async {
    late UserProfile userProfile;
    String? authToken = await AuthService().getToken();

    final response = await http.get(
      Uri.parse('$apiUrl/my-profile'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      userProfile = UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to load user profile');
    }
    return userProfile;
  }

  Future<bool> editUserName(String newName) async {
    String? authToken = await AuthService().getToken();

    final Map<String, String> requestData = {'newUserName': newName};

    final http.Response response = await http.post(
      Uri.parse('$apiUrl/edit-username'),
      body: jsonEncode(requestData),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> changePassword(
      String newPassword, String currentPassword) async {
    String? authToken = await AuthService().getToken();

    final Map<String, String> requestData = {
      'newPassword': newPassword,
      'currentPassword': currentPassword
    };

    final http.Response response = await http.post(
      Uri.parse('$apiUrl/change-password'),
      body: jsonEncode(requestData),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
