import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/user_profile.dart';

class UserDetailsProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;

  File? get image => _image;

  UserProfilePage getUserProfile() {
    return UserProfilePage(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      profileImage: _image != null ? _image!.path : '',
    );
  }

  void saveUserProfile() async {
    // Save the user profile using Hive
    final userBox = await Hive.openBox('userProfileBox');
    final userProfile = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };
    await userBox.put('userProfile', userProfile);
    userBox.close();

    // Save the image path using shared_preferences
    if (_image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final imagePath = appDir.path + '/profileImage.png';
      _image!.copy(imagePath);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImagePath', imagePath);
      print('Image path saved: $imagePath');
    }
  }

  Future<void> loadUserProfile() async {
    // Load the user profile from Hive
    final userBox = await Hive.openBox('userProfileBox');
    final userProfile = userBox.get('userProfile');

    if (userProfile != null) {
      nameController.text = userProfile['name'];
      emailController.text = userProfile['email'];
      phoneController.text = userProfile['phone'];

      notifyListeners();
    }

    // Load the image path using shared_preferences
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      _image = File(imagePath);
      notifyListeners();
    }
  }

  Future<void> selectImageFromDevice(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            child: Text('Camera'),
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          TextButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        notifyListeners();
      }
    }
  }
}
