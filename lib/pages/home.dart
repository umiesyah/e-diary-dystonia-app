import 'package:dystoniadiary/main.dart';
import 'package:dystoniadiary/pages/navone.dart';
import 'package:dystoniadiary/pages/navthree.dart';
import 'package:dystoniadiary/pages/navtwo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  late String _name;
  late String _phoneNumber;
  late String _age;
  late String _profileImageUrl;

  List<Widget> _pages = [
    Navone(),
    Navtwo(),
    Navthree(),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('userdata')
            .doc('profile')
            .get();
        final data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          _name = data['name'];
          _phoneNumber = data['phoneNumber'];
          _age = data['age'];
          _profileImageUrl = data['profileImageUrl'];
        });
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  Future<void> logout() async {
    try {
      await firebase_auth.FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (route) => false,
      );
    } catch (e) {
      print('Failed to logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: palletcolor.light,
        title: Text(
          'Dystonia Diary',
          style: TextStyle(color: palletcolor.darker),
        ),
      ),
      backgroundColor: palletcolor.light,
      drawer: Drawer(
        backgroundColor: palletcolor.light,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                _name,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                _phoneNumber,
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl) as ImageProvider<Object>?
                    : AssetImage("assets/images/default_profile_image.png"),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: palletcolor.light,
        selectedItemColor: palletcolor.darker,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Treatment',
          ),
        ],
      ),
    );
  }
}
