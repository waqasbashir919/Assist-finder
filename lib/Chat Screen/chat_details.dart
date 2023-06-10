import 'package:asist_finder/const/appColors..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatDetails extends StatefulWidget {
  // final dynamic selectedJob;
  final String? chatRoomId;
  final String? sentByName;
  const ChatDetails(
      {super.key,
      //  this.selectedJob,
      this.chatRoomId,
      this.sentByName});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var sentToUserId;
  var loggedUserName;
  @override
  void initState() {
    super.initState();
    // fetchUser();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.green,
          title: Text('${widget.sentByName}')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatRoom')
                    .doc(widget.chatRoomId)
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var messages = snapshot.data!.docs;

                    if (messages.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Hi'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.sentByName}'),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: messages.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = messages[index];

                          bool isMe = message['sentById'] == currentUser;
                          print(message['createdAt']);
                          // var formattedDate =
                          //     DateFormat('hh:mm:a').format(message['createdAt']);
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: isMe
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  isMe
                                      ? Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 3),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15))),
                                          child: Text(
                                            '${message['message']}',
                                            softWrap: true,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 15.0,
                                              backgroundImage: AssetImage(
                                                  'assets/images/user.png'),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, top: 3, bottom: 3),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade600,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                    )),
                                                child: Text(
                                                  '${message['message']}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        )
                                ],
                              ),
                              // Text('${formattedDate}'),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                Container(
                  color: AppColors.green,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String message = _textEditingController.text.trim();

                      if (message.isNotEmpty) {
                        setState(() {
                          sentMessage();
                          _textEditingController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  // fetchUser() async {
  //   var docRef = await FirebaseFirestore.instance
  //       .collection('users/')
  //       .doc(currentUser)
  //       .snapshots();
  //   docRef.first.then((value) {
  //     setState(() {
  //       loggedUserName = value['firstname'];
  //     });
  //     sentToUserId = widget.selectedJob['ref_id'];
  //   });
  // }

  void sentMessage() async {
    // final refMessages = FirebaseFirestore.instance
    //     .collection('chats/${widget.selectedJob['ref_id']}/messages');

    // final refMessages = FirebaseFirestore.instance.collection(
    //     'chatRoom/${currentUser}_${sentToUserId}/chats/${sentToUserId}/messages');

    // Map<String, dynamic> messageInfo = {
    //   'sentByName': loggedUserName,
    //   'sentById': currentUser,
    //   'message': _textEditingController.text,
    //   'createdAt': DateTime.now(),
    // };
    // await refMessages.add(messageInfo);

    Map<String, dynamic> messageInfo = {
      'sentByName': widget.sentByName,
      'sentById': currentUser,
      'message': _textEditingController.text,
      'createdAt': DateTime.now(),
    };

    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(widget.chatRoomId)
        .collection('messages')
        .add(messageInfo);
  }
}
