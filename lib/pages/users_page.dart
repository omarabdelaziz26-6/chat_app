// import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/widgets/users_page_body.dart';

import '../constants.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  static String userPageRoute = "UserPage";
  static CollectionReference messages =
      FirebaseFirestore.instance.collection(kUsersCollection);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    String senderEmail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        //علشان الغي الباك ارو
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            ChatPage.messageController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.exit_to_app_rounded),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              "Chat",
              style: TextStyle(
                color: Color(0xFFC7EDE6),
              ),
            ),
          ],
        ),
      ),
      body: UsersPageBody(senderEmail: senderEmail),
    );
  }
}
