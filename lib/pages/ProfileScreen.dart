import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                user.setUsername(_unameController.text);
              }
              setState(() => isEditing = !isEditing);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: isEditing ? () => _pickImage(context) : null,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    user.profilePicPath != null
                        ? Image.file(File(user.profilePicPath!)).image
                        : null,
                child:
                    user.profilePicPath == null
                        ? Icon(Icons.person, size: 50)
                        : null,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _unameController,
              enabled: isEditing,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 24),
            // Add more user detail fields here if needed
          ],
        ),
      ),
    );
  }
}
