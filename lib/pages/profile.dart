import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/auth/login.dart';
import 'package:fluuter/pages/updateprofile.dart';
import "package:firebase_storage/firebase_storage.dart" as firebase_storage;

final firebaseInstance = FirebaseFirestore.instance;

firebase_storage.FirebaseStorage _storage =
    firebase_storage.FirebaseStorage.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String location = 'ok';
  List pdata = ['', '', '', ''];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: firebaseInstance
                      .collection('users')
                      .doc(user!.uid)
                      .get()
                      .then((value) {
                    pdata[0] = value.data()!['Name'];
                    pdata[1] = value.data()!['Gender'];
                    pdata[2] = value.data()!['Gmail'];
                    pdata[3] = value.data()!['Phone'];
                    return value.data();
                  }),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final daata = snapshot.data!;
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.2,
                              child: FutureBuilder(
                                future: _storage
                                    .ref('users/ProfilePicture/${user.uid}')
                                    .getDownloadURL(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Icon(
                                        Icons.person,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                      backgroundImage:
                                          NetworkImage(snapshot.data),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Center(
                            child: Text(
                              pdata[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.065,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(pdata[1] == 'Male'
                                          ? Icons.male
                                          : Icons.female),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: 'Gender\n',
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                              text: pdata[1],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: 'Phone Number\n',
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                              text: pdata[3],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.email),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: 'Email\n',
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                              text: pdata[2],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.shade400,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileUpdate(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Update Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: MaterialButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      print(user.toString());
                                      if (user == null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LogIn()));
                                      } else {
                                        print('something went wrong');
                                      }
                                    },
                                    child: Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
