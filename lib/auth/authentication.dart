import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/simplify.dart';

Future<bool> signIn(String email, String password,BuildContext context) async {
  // try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password).catchError((onError){
           showCustomDialog(context, title: onError.toString());
        });
    // print(FirebaseAuth.instance.currentUser.toString());
    return true;
  // }
  // catch (e) {
  //   showCustomDialog(context, title: e.toString());
  //   print(e);
  //   return false;
  // }
}

Future<User?> signUp(
  String name,
  String email,
  String password,
  String gender,
  String phone,
) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  final firebaseInstance = FirebaseFirestore.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Usser usser = Usser(gender: gender, name: name, phone: phone, gmail: email);
    user = userCredential.user;
    user = auth.currentUser;
    firebaseInstance
        .collection('users')
        .doc(user!.uid)
        .set(usser.toJson())
        .then((_) {
      print('success');
    });
    // .doc(user!.uid)
    // .set(
    //   usser.toJson(),
    // )
    // .then((_) => print('success'));

    // await user!.updateDisplayName(name);
    // await user.reload();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exist for that email');
    }
    // return false;
  } catch (e) {
    print(e.toString());
    // return false;
  }
  return user;
}

Future<String?> changePassword(String currentPassword, String newPassword,context) async {
  var user =await FirebaseAuth.instance.currentUser;
  user!.reload();
  user = await FirebaseAuth.instance.currentUser;
  final cred = EmailAuthProvider.credential(
      email: user!.email.toString(), password: currentPassword);
  user.reauthenticateWithCredential(cred).then((value) {
    user!.updatePassword(newPassword).then((e) {
      showCustomDialog(context, title: 'Success');
      return 'Success';
    }).catchError((onError){
      showCustomDialog(context, title:onError..toString());
      return 'onError.toString()';
    });
  }).catchError((onError){
     showCustomDialog(context, title: "Current Password doesn't match");
    return "Current Password doesn't match";
  });
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
