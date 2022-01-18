import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/pages/profile.dart';
import 'package:fluuter/pages/strangers.dart';

FirebaseAuth auth = FirebaseAuth.instance;
User? getUser() {
  final User? user;
  user = auth.currentUser;
  return user;
}

class WelcomePage extends StatefulWidget {
  final index;
   WelcomePage({Key? key,@required this.index}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int index =0;
  @override
  void initState() {
    super.initState();
    index=widget.index!=null?widget.index:0;
  }
  final screens = [
     StrangerPeople(),
     ProfilePage(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueAccent.shade400,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black87,
          selectedIconTheme: IconThemeData(
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.06),
          currentIndex: index,
          onTap: (e) {
            setState(() {
              index = e;
            });
          },
          items:  [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat_bubble_outline_outlined),
            //   label: 'Chat',
            //   backgroundColor: Colors.white,
            // ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Strangers',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
