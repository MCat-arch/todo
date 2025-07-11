import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/about.dart';
import 'package:to_do_app/pages/set_notification.dart';
import 'package:to_do_app/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _unameController = TextEditingController();
  bool isEditing = false;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setProfilePic(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    _unameController.text = user.username;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EC),
      body: Column(
        children: [
          // Gradient Header
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB1D1FD), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          user.profilePicPath != null
                              ? FileImage(File(user.profilePicPath!))
                              : null,
                      backgroundColor: Colors.grey[300],
                      child:
                          user.profilePicPath == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _pickImage(context),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.add, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   user.email ?? 'nickforest@gmail.com',
                //   style: const TextStyle(fontSize: 14, color: Colors.black54),
                // ),
                const Text(
                  'since 12 March 2020',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // Buttons
          Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    _buildMenuButton(
                      context,
                      icon: Icons.notifications,
                      label: "Notifikasi",
                      color: const Color(0xFFFDF7EC),
                      textColor: Colors.black87,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingNotification(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      icon: Icons.info_outline,
                      label: "About Us",
                      color: const Color(0xFFFDF7EC),
                      textColor: Colors.black87,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const About(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      icon: Icons.power_settings_new,
                      label: "Log Out",
                      color: const Color(0xFFFFC1C1),
                      textColor: Colors.black87,
                      onTap: () {
                        // Do logout here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
