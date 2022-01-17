import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluuter/pages/updateprofile.dart';

// final id = user!.uid != 'YPrOHCWzoveNADSZ71FacoseBcs1'
//     ? 'YPrOHCWzoveNADSZ71FacoseBcs1'
//     : 'pWzMqogzqkfjaDbLtdaLgXGeEVH3';
getUser() {
  var user = FirebaseAuth.instance.currentUser;
  user!.reload();
  user = FirebaseAuth.instance.currentUser;
  return user!.uid;
}

class ChatPage extends StatefulWidget {
  final id;
  final name;
  const ChatPage({Key? key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final firebaseInstance = FirebaseFirestore.instance;
  final TextEditingController _chat = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  setData(id, uid, message) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Chat/$uid/$id");
    await ref.push().set({
      "message": message,
      "Hour": DateTime.now().hour.toString(),
      "Minute": DateTime.now().minute.toString(),
      "ID":uid,
    });
  }

  setData1(id, uid, message) async {
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("Chat/$id/$uid");
    await ref2.push().set({
      "message": message,
      "Hour": DateTime.now().hour.toString(),
      "Minute": DateTime.now().minute.toString(),
      "ID":uid,
    });
  }

  // getData() async {
  //   DatabaseEvent event = await ref.once();
  //   print(event.snapshot.value);
  // }

  // getStream() async {
  //   Stream<DatabaseEvent> stream = ref.onValue;
  //   stream.listen((DatabaseEvent event) {});
  // }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    final uid = getUser();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name.toString()),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  controller: _scrollController,
                  query: FirebaseDatabase.instance
                      .ref("Chat/${user!.uid}/$id"),
                  itemBuilder: (context, snapshot, animation, index) {
                    try {
                      var data = snapshot.value as Map<dynamic, dynamic>;
                      return Row(
                        mainAxisAlignment: data['ID'] == uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: index % 2 == 0
                                  ? Alignment.bottomRight
                                  : Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                data['message'],
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } catch (e) {
                      print(snapshot.value);
                      return Text(e.toString());
                    }
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _chat,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.email),
                          hintText: 'Your Message',
                          labelText: "Chat",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          if (_chat.text.isEmpty) {
                          } else {
                            setData(id, uid, _chat.text);
                            setData1(id, uid, _chat.text);
                            _chat.clear();
                          }
                        },
                        child: Icon(
                          Icons.send_rounded,
                          size: MediaQuery.of(context).size.width * 0.1,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
