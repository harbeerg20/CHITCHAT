import 'package:flutter/material.dart';
import 'package:fluuter/auth/authentication.dart';
import 'package:fluuter/auth/register%20.dart';
import 'package:fluuter/pages/forgotpassword.dart';
import 'package:fluuter/pages/welcomepage.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isobscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent.shade400,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Card(
              margin: EdgeInsets.zero,
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
                      "Sign In",
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          hintText: 'something@gmail.com',
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _password,
                        obscureText: _isobscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: 'Password',
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isobscure = !_isobscure;
                              });
                            },
                            icon: Icon(_isobscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.083,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MaterialButton(
                      color: Colors.blueAccent.shade400,
                      onPressed: () async {
                        print(_email.text);
                        print(_password.text);
                        bool shouldnavigate =
                            await signIn(_email.text, _password.text, context);
                        if (shouldnavigate) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ),
                          );
                          _email.clear();
                          _password.clear();
                        }
                      },
                      child: Text("Sign In"),
                      textColor: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text('Sign Up')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
