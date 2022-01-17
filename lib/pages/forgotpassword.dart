import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
              Container(
                // height: MediaQuery.of(context).size.height * 0.04,
                // width: MediaQuery.of(context).size.width * 0.2,
                child: MaterialButton(
                  onPressed: () async {
                    String error;
                    final firebaseinstace = FirebaseAuth.instance;
                    try {
                      await firebaseinstace.sendPasswordResetEmail(
                          email: _email.text);
                    } catch (e) {
                      print(e.toString());
                      error = e.toString();
                    }
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.transparent,
                          content: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Get Link"),
                  textColor: Colors.white,
                ),
                decoration: BoxDecoration(
                    // shape:BoxShape.circle,
                    color: Colors.blueAccent.shade400,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
