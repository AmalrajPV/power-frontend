import 'package:flutter/material.dart';
import 'package:power_monitor/models/user_model.dart';
import 'package:power_monitor/services/user_service.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  UserProfileProvider() {
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final userProfile = await UserService().myProfile();
      _userProfile = userProfile;
      notifyListeners();
    } catch (error) {
      //
    }
  }

  void updateUserProfile() async {
    final userProfile = await UserService().myProfile();
    _userProfile = userProfile;
    notifyListeners();
  }
}
