import 'package:cineandgo/components/message_bubble.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Firestore _db = Firestore.instance;
FirebaseUser loggedInUser;

class ChatRoom extends StatefulWidget {
  ChatRoom({@required this.roomId});

  final String roomId;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String roomId;
  Query query;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getQuery();
  }

  void getQuery() {
    roomId = widget.roomId;
    query =
        _db.collection('chatrooms').where('roomid', isEqualTo: widget.roomId);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(
                query: query,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: kAccentColor, width: 2.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: AppLocalizations.of(context)
                              .translate('type_message'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (messageText != null &&
                            messageText.trim().isNotEmpty) {
                          messageTextController.clear();

                          query.getDocuments().then(
                            (docs) {
                              String docId = docs.documents[0].documentID;

                              _db
                                  .collection('chatrooms')
                                  .document(docId)
                                  .updateData(
                                {
                                  'messages': FieldValue.arrayUnion(
                                    [
                                      {
                                        'sender': loggedInUser.email,
                                        'text': messageText.trim(),
                                      }
                                    ],
                                  ),
                                },
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: kAccentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
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

class MessagesStream extends StatelessWidget {
  MessagesStream({@required this.query});

  final Query query;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kAccentColor,
            ),
          );
        }
        final messages = snapshot.data.documents[0].data['messages'];
        List<MessageBubble> messageBubbles = [];

        for (var message in messages.reversed) {
          final messageText = message['text'];
          final messageSender = message['sender'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender.split('@')[0],
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
