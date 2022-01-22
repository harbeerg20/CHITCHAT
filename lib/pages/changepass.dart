import 'package:flutter/material.dart';
import 'package:fluuter/auth/authentication.dart';
import 'package:fluuter/pages/welcomepage.dart';

class ChangePassword extends StatefulWidget {
   ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentpasswod = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Update Password",
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
                        controller: _currentpasswod,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(_currentpasswod.text.isEmpty||_currentpasswod.text==null){
                            return "Required";
                          }
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: '******',
                          labelText: "Current Password",
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
                        controller: _newpassword,
                        obscureText: true,
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (_newpassword.text.isEmpty ||
                              _newpassword.text == null) {
                            return "Required";
                          }
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: '*******',
                          labelText: "New Password",
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
                        controller: _confirmpassword,
                        obscureText: true,
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (_newpassword.text !=_confirmpassword.text) {
                            return "Passwords doesn't match";
                          }
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: '*******',
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.027,
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () async {
                          if(_currentpasswod.text.isEmpty||_newpassword.text.isEmpty||_currentpasswod.text.isEmpty){
                            showCustomDialog(context, title: 'All fields are required');
                          }
                         else if (_newpassword.text == _confirmpassword.text) {
                            var res = await changePassword(_currentpasswod.text,
                                _newpassword.text, context);
                            
                          } 
                         
                        },
                        child:  Text("Update"),
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
                        Text('Go to'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomePage(index: 1),
                                ),
                              );
                            },
                            child: Text('Profile Page'))
                      ],
                    ),
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
