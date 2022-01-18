import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/pages/changepass.dart';
import 'package:fluuter/pages/profile.dart';
import 'package:fluuter/pages/welcomepage.dart';
import '../model/user.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

final firebaseInstance = FirebaseFirestore.instance;
// final User? user = FirebaseAuth.instance.currentUser;
getUser() {
  var user = FirebaseAuth.instance.currentUser;
  user!.reload();
  user = FirebaseAuth.instance.currentUser;
  return user;
}

class ProfileUpdate extends StatefulWidget {
  // final User? user;
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  var user;
  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  List pdata = [];
  String valuee = '';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final userr = getData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: firebaseInstance
              .collection('users')
              .doc(user!.uid)
              .get()
              .then((value) {
            pdata.add(value.data()!['Name']);
            _name.text = value.data()!['Name'];
            pdata.add(value.data()!['Gender']);

            valuee = value.data()!['Gender'];
            pdata.add(value.data()!['Gmail']);
            _email.text = value.data()!['Gmail'];
            pdata.add(value.data()!['Phone']);
            _phone.text = value.data()!['Phone'];
            return pdata;
          }),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Stack(children: [
                  Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Icon(
                          Icons.account_box_rounded,
                          size: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 3,
                          indent: MediaQuery.of(context).size.width * 0.1,
                          endIndent: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue.shade600,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              controller: _name,
                              // initialValue: pdata[0],
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue.shade600,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              // initialValue: pdata[2],
                              controller: _email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue.shade600,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              // initialValue: pdata[3],
                              controller: _phone,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'PhoneNumber',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0,
                              0,
                              MediaQuery.of(context).size.width * 0,
                              0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 113, 143, 203))),
                          child: DropDown(
                            isExpanded: true,
                            showUnderline: false,
                            hint: const Text('Gender'),
                            initialValue: valuee,
                            items: const ['Male', 'Female'],
                            onChanged: (e) {
                              valuee = e.toString();
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: MaterialButton(
                            onPressed: () async {
                              Usser usser = Usser(
                                  name: _name.text,
                                  gender: valuee,
                                  phone: _phone.text,
                                  gmail: _email.text);
                              final ussers = usser.toJson();
                              try {
                                firebaseInstance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .update(ussers);
                                user!.updateEmail(_email.text);
                                user!.reload();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(
                                      index: 1,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: const Text("Update"),
                            textColor: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              // shape:BoxShape.circle,
                              color: Colors.blueAccent.shade400,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
