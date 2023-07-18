import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_provider/user_provider.dart';

class UserProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  const UserProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
  }) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    userDetailsProvider.loadUserProfile();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: userDetailsProvider.image != null
                        ? FileImage(userDetailsProvider.image!)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          userDetailsProvider.selectImage(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.nameController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    // Reset error text if the field is not empty
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.emailController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
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
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userDetailsProvider.phoneController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey.shade200,
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
            ],
          ),
        ),
      ),
    );
  }
}
