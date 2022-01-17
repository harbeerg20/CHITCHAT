import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // print(FirebaseAuth.instance.currentUser.toString());
    return true;
  } catch (e) {
    print(e);
    return false;
  }
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
      print('succes');
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
