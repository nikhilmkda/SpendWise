import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_provider/user_provider.dart';

class UserProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const UserProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    // Load user profile data when the page is initialized
    // Provider.of<UserDetailsProvider>(context, listen: false).loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User profile image section
              Stack(
                children: [
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: userDetailsProvider.imageBytes != null
                        ? MemoryImage(userDetailsProvider.imageBytes!)
                        : AssetImage('assets/userProfileImage.png')
                            as ImageProvider,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          // Open image selection from device
                          userDetailsProvider.selectImageFromDevice(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50.0),
              if (userDetailsProvider.loadingFailed)
                Text(
                  'No user data found! Add details or reload the page.',
                  style: TextStyle(
                    color: Colors.red,
                    // You can customize the style
                  ),
                ),
              SizedBox(height: 50.0),
              // User name input
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.nameController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // User email input
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.emailController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // User phone number input
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.phoneController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Save profile button
              ElevatedButton(
                onPressed: () {
                  if (userDetailsProvider.nameController.text.isEmpty ||
                      userDetailsProvider.emailController.text.isEmpty ||
                      userDetailsProvider.phoneController.text.isEmpty) {
                    // Show a snack bar to fill all details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all the details')),
                    );
                  } else {
                    try {
                      // Save the user profile
                      userDetailsProvider.saveUserProfile();

                      // Show a success message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Profile saved successfully!'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      // Show an error message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to save profile!'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(400, 50),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
