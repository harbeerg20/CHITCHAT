import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluuter/auth/authentication.dart';
import 'package:fluuter/auth/login.dart';
import 'package:fluuter/pages/welcomepage.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isobscurePass = true;
  bool _isobscureConfirmPass = true;
  String value = 'Male';
  final _gender = ['Male', 'Female'];
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  // TextEditingController _ggender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent.shade400,
      body: Stack(children: [
        Card(
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
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
                  "Sign Up",
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
                    controller: _name,
                    decoration: InputDecoration(
                      // icon: Icon(Icons.email),
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
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
                      // icon: Icon(Icons.email),
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      // icon: Icon(Icons.email),
                      hintText: 'PhoneNumber',
                      labelText: 'PhoneNumber',
                      border: OutlineInputBorder(),
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
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Color.fromARGB(255, 113, 143, 203))),
                  child: DropDown(
                    isExpanded: true,
                    showUnderline: false,
                    hint: Text('Gender'),
                    initialValue: value,
                    items: ['Male', 'Female'],
                    onChanged: (e) {
                      value = e.toString();
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _password,
                    obscureText: _isobscurePass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isobscurePass = !_isobscurePass;
                          });
                        },
                        icon: Icon(_isobscurePass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    obscureText: _isobscureConfirmPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isobscureConfirmPass = !_isobscureConfirmPass;
                          });
                        },
                        icon: Icon(_isobscureConfirmPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.04,
                  // width: MediaQuery.of(context).size.width * 0.2,
                  child: MaterialButton(
                    onPressed: () async {
                      User? user = await signUp(_name.text, _email.text,
                          _password.text, value, _phone.text);
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomePage(),
                          ),
                        );
                      } else {
                        print('no');
                      }
                    },
                    child: Text("Sign Up"),
                    textColor: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      // shape:BoxShape.circle,
                      color: Colors.blueAccent.shade400,
                      borderRadius: BorderRadius.circular(5)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text('Sign In')),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
