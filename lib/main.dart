import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluuter/auth/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyCbDqbhnfSO7JQDuANKt2-bDrLQ3v4k-dQ",
    //   appId: '1:947020970604:android:fe726c875cc4be52f8f649',
    //   messagingSenderId: '947020970604',
    //   projectId: 'chitchat-8ac0c',
    //   databaseURL: 'https://chitchat-8ac0c-default-rtdb.firebaseio.com/',
    // ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChIt ChAt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
      // FutureBuilder(
      //   future: _fbapp,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       print('You have an error! ${snapshot.error.toString()}');
      //       return Text('Something went wrong');
      //     } else if (snapshot.hasData) {
      //       return LogIn();
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
