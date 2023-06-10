import 'package:asist_finder/Chat%20Screen/chat_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../const/appColors..dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var loggedUserName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Recent Chats'),
        backgroundColor: AppColors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Text(
          //     'Recent Chats',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fetchChatRooms(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = documents[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDetails(
                                        chatRoomId: data['chatRoomId'],
                                        sentByName: data['chatRoomId']
                                            .toString()
                                            .replaceAll('_', '')
                                            .replaceAll(loggedUserName, ''),
                                        // fromJobPage: false
                                      )));
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['chatRoomId']
                                          .toString()
                                          .replaceAll('_', '')
                                          .replaceAll(loggedUserName, ''),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text('Last chat ${data['Lastname']}')
                                  ],
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    ));
  }

  fetchUser() async {
    var docRef = await FirebaseFirestore.instance
        .collection('users/')
        .doc(currentUser)
        .snapshots();
    docRef.first.then((value) {
      setState(() {
        loggedUserName = value['firstname'];
      });
    });
  }

  Stream<QuerySnapshot> fetchChatRooms() {
    // return FirebaseFirestore.instance
    // .collection('chatRoom');

    return FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: loggedUserName)
        .snapshots();
  }
}
