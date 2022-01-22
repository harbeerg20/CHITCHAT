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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value){
                      if(value!.isEmpty||_name.text==null){
                        return 'Name is required';
                      }
                    },
                    // onChanged: (String userInput){
                    //   if (value.isEmpty || _name.text == null) {
                    //     showCustomDialog(context, title: 'Name is required');
                    //   }
                    //   setState(() {
                    //     debugPrint(userInput);
                    //   });

                    //},
                    decoration: InputDecoration(
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty || _email.text == null) {
                        return 'Email is required';
                      }
                    },
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty || _phone.text == null) {
                        return 'PhoneNumber is required';
                      }
                    },
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty || _password.text == null) {
                        return 'Password is required';
                      }
                    },
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
                    controller: _cpassword,
                    obscureText: _isobscureConfirmPass,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if ( _cpassword.text !=_password.text) {
                        return "Passwords doesn't match";
                      }
                    },
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
                MaterialButton(
                  color: Colors.blueAccent.shade400,
                  onPressed: () async {
                    if(_name.text.isEmpty||_email.text.isEmpty||_phone.text.isEmpty||_password.text.isEmpty||!_cpassword.text.isEmpty){
                      showCustomDialog(context, title: 'All fields are required');
                    }else if(_password.text==_cpassword.text){
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
                      showCustomDialog(context, title: 'Something went wrong\n try again');
                    }
                    }
                    // if(_password.text!=_cpassword.text){
                    //     showCustomDialog(context, title: "Passwords doesn't match");
                    // }
                    // User? user = await signUp(_name.text, _email.text,
                    //     _password.text, value, _phone.text);
                    // if (user != null) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => WelcomePage(),
                    //     ),
                    //   );
                    // } else {
                    //   print('no');
                    // }
                  },
                  child: Text("Sign Up"),
                  textColor: Colors.white,
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


void showCustomDialog(
  BuildContext context, {
  required String title,
}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          // title: Text(title.toString()),
          content: Text(title.toString()),
          actions: <Widget>[
            MaterialButton(
                child: Text('Close'), onPressed: () => Navigator.pop(context))
          ],
        );
      });
}