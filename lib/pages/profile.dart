import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/auth/login.dart';
import 'package:fluuter/pages/updateprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List pdata = ['', '', '', ''];
  @override
  @override
  Widget build(BuildContext context) {
    final firebaseInstance = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    // print(user);
    // final userr = getData();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Profile'),
            ),
            automaticallyImplyLeading: false,
          ),
          body: FutureBuilder(
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
                return const Center(
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
                        // backgroundImage: NetworkImage(
                        //   "https://via.placeholder.com/150",
                        // ),
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
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Gender\n',
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: pdata[1],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Phone Number\n',
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: pdata[3],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.03,
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Email\n',
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: pdata[2],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // color: Colors.blueAccent.shade400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent.shade400,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileUpdate(),
                              ),
                            );
                          },
                          child: const Text(
                            'Update Profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // color: Colors.blueAccent.shade400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent.shade400,
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            final user = FirebaseAuth.instance.currentUser;
                            print(user.toString());
                            if (user == null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()));
                            } else {
                              print('something went wrong');
                            }
                          },
                          child: const Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}