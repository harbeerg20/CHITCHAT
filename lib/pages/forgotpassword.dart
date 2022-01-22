import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/auth/authentication.dart';
import 'package:fluuter/auth/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
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
              "Forgot Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide email';
                  }
                  return null;
                  // return null;
                },
                decoration: const InputDecoration(
                  // icon: Icon(Icons.email),
                  hintText: 'something@gmail.com',
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () async {
                final firebaseinstace = FirebaseAuth.instance;
                try {
                  await firebaseinstace.sendPasswordResetEmail(
                      email: _email.text);
                  showCustomDialog(context, title: 'Email sent');
                } catch (e) {
                  print(e.toString());
                  showCustomDialog(context, title: e.toString());
                }
              },
              child: const Text("Get Link"),
              textColor: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Go to'),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogIn(),
                        ),
                      );
                    },
                    child: Text('Sign In'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
