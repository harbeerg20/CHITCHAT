import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter/pages/chat.dart';
import "package:firebase_storage/firebase_storage.dart" as firebase_storage;

class StrangerPeople extends StatefulWidget {
  const StrangerPeople({
    Key? key,
  }) : super(key: key);

  @override
  _StrangerPeopleState createState() => _StrangerPeopleState();
}

class _StrangerPeopleState extends State<StrangerPeople> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fb = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  String sendImage='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You May Know'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            StreamBuilder(
              stream: _fb.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: const Center(child: CircularProgressIndicator()));
                } else if (!snapshot.hasData) {
                  return const Text('Something went wrong');
                } else {
                  final data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        if (document.id == _auth.currentUser!.uid) {
                          return Container(
                            height: 0,
                          );
                        } else {
                          final data = document.data() as Map<dynamic, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                minVerticalPadding:
                                    MediaQuery.of(context).size.width * 0.03,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: CircleAvatar(
                                 
                                  child: FutureBuilder(
                                    future: _storage
                                        .ref(
                                            'users/ProfilePicture/${document.id}')
                                        .getDownloadURL(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: Icon(
                                            Icons.person,
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        sendImage=snapshot.data;
                                        return CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          backgroundImage:
                                              NetworkImage(snapshot.data),
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                title: Text(
                                  ' ${data["Name"]}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                          id: document.id, name: data['Name'], ),
                                      // id: document.id,name: data['Name'],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
