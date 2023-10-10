// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:power_monitor/services/user_provider.dart';
import 'package:power_monitor/services/user_service.dart';
import 'package:power_monitor/utils/password_validator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    var userProfile = userProfileProvider.userProfile;
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Profile"),
          // backgroundColor: const Color(0xFF44BAC2),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("User Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 56, 153, 160)),
                  textScaleFactor: 1.5),
              const SizedBox(
                height: 20,
              ),
              _buildProfileField(
                  'Username', userProfile?.userName ?? "", Icons.person),
              _buildProfileField(
                  'Email', userProfile?.email ?? "", Icons.email),
              _buildProfileField('Consumer Number',
                  userProfile?.consumerId ?? "", Icons.numbers),
              _buildProfileField(
                  'Product ID', userProfile?.productId ?? "", Icons.numbers),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Card(
                  elevation: 0,
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () =>
                                _editUsername(userProfile?.userName ?? ""),
                            child: const Text("Edit username")),
                        TextButton(
                            onPressed: _changePassword,
                            child: const Text("Change password")),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // color: Color(0xFF44BAC2),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editUsername(String currentName) {
    TextEditingController newuserName =
        TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var userProfileProvider = Provider.of<UserProfileProvider>(context);
        return AlertDialog(
          title: const Text("Edit Username"),
          content: TextField(
            controller: newuserName,
            decoration: const InputDecoration(labelText: "New Username"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await UserService().editUserName(newuserName.text.trim());
                userProfileProvider.updateUserProfile();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _changePassword() {
    TextEditingController cp = TextEditingController();
    TextEditingController np = TextEditingController();
    TextEditingController npc = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: ValidationBuilder()
                    .minLength(6, 'Password must be at least 6 characters long')
                    .build(),
                controller: cp,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Current Password"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: ValidationBuilder()
                    .minLength(6, 'Password must be at least 6 characters long')
                    .build(),
                controller: np,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: ValidationBuilder()
                    .minLength(6, 'Password must be at least 6 characters long')
                    .password(np.text)
                    .build(),
                controller: npc,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  UserService().changePassword(np.text, cp.text);
                }
                Navigator.pop(context);
              },
              child: const Text("Change"),
            ),
          ],
        );
      },
    );
  }
}
