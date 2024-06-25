import 'package:chatapp/chat/display_message.dart';
import 'package:chatapp/screen/login_signUp/login.dart';
import 'package:chatapp/screen/login_signUp/services/authentication..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String name;
  const ChatPage({super.key, required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // for message
  final TextEditingController messageController = TextEditingController();
  //for firebase instance
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //for auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        actions: [
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.blueAccent,
            onPressed: () async {
              await AuthServices().signOUt();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: DisplayMessage(
                name: widget.name,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        enabled: true,
                        hintText: 'Message',
                        contentPadding:
                            const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        messageController.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        firebaseFirestore.collection('message').doc().set({
                          'message': messageController.text.trim(),
                          'time': DateTime.now(),
                          'name': widget.name,
                        });
                        messageController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send_sharp,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
