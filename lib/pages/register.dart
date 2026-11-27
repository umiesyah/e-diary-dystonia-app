import 'dart:io';

import 'package:dystoniadiary/main.dart';
import 'package:dystoniadiary/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImageAndSignUp(BuildContext context) async {
    try {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an image'),
          ),
        );
        return;
      }

      // Upload image to Firebase Storage
      final imageName = DateTime.now().toString();
      final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$imageName.jpg');
      final firebase_storage.UploadTask uploadTask = ref.putFile(_selectedImage!);
      final firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
      final imageUrl = await storageSnapshot.ref.getDownloadURL();

      // Create user in Firebase Authentication
      final firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('userdata') // Create 'userdata' collection
          .doc('profile') // Use 'profile' as the document ID for user profile data
          .set({
        'email': _email.text.trim(),
        'profileImageUrl': imageUrl,
        'name': _name.text.trim(),
        'age': _age.text.trim(),
        'phoneNumber': _phoneNumber.text.trim(),
        // Add other user data fields as needed
      });

      // Navigate to home page
       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register user: $e'),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData prefixIcon) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      prefixIcon: Icon(prefixIcon, color: palletcolor.darker),
      labelText: label,
      border: InputBorder.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palletcolor.dark,
      appBar: AppBar(
        backgroundColor: palletcolor.dark,
        title: Text('Register'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
             children: [
              Image.asset(
                'assets/images/logo.png',
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Take a Photo'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Choose from Gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [palletcolor.light],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: TextField(
                  controller: _email,
                  style: TextStyle(color: Colors.black),
                  decoration: _buildInputDecoration('Email', Icons.email),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [palletcolor.light],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: TextField(
                  controller: _pass,
                  style: TextStyle(color: Colors.black),
                  decoration: _buildInputDecoration('Password', Icons.password),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [palletcolor.light],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: TextField(
                  controller: _name,
                  style: TextStyle(color: Colors.black),
                  decoration: _buildInputDecoration('Name', Icons.person),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [palletcolor.light],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: TextField(
                  controller: _age,
                  style: TextStyle(color: Colors.black),
                  decoration: _buildInputDecoration('Age', Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [palletcolor.light],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: TextField(
                  controller: _phoneNumber,
                  style: TextStyle(color: Colors.black),
                  decoration: _buildInputDecoration('Phone Number', Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  _uploadImageAndSignUp(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [palletcolor.light],
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20),
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
}
