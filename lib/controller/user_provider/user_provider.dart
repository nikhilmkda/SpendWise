import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';


class UserDetailsProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;

  File? get image => _image;
  Uint8List? imageBytes;
  bool loadingFailed = false;

  void saveUserProfile() async {
    // Save the user profile using Hive
    final userBox = await Hive.openBox('userProfileBox');
    final userProfile = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'profileImageBytes': imageBytes != null ? imageBytes!.toList() : null,
    };
    await userBox.put('userProfile', userProfile);
    userBox.close();
    notifyListeners();
  }

  Future<void> loadUserProfile() async {
    // Load the user profile from Hive
    final userBox = await Hive.openBox('userProfileBox');
    final userProfile = userBox.get('userProfile');

    if (userProfile != null) {
      nameController.text = userProfile['name'];
      emailController.text = userProfile['email'];
      phoneController.text = userProfile['phone'];

      // Check if the 'profileImageBytes' key is present and not null
      if (userProfile.containsKey('profileImageBytes') &&
          userProfile['profileImageBytes'] != null) {
        final imageUser = userProfile['profileImageBytes'] as List<int>;
        imageBytes = Uint8List.fromList(imageUser);
      } else {
        // Handle the case when profile image is null or missing
        imageBytes =
            null; // Set imageBytes to null or provide a default image if needed
      }

      notifyListeners();
    } else {
      // Set loadingFailed to true when data loading fails
      loadingFailed = true;
      notifyListeners();
    }
  }

//show user data loading error in userdetails page

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

        // Convert the image to bytes (you can use a utility function for this)
        imageBytes = await pickedFile.readAsBytes();
        saveUserProfile(); //to save userprofilepic instantly after selecting
        notifyListeners();
      }
    }
  }
}
