import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/chat_page_body.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static String chatPageRoute = "chatPageRoute";

  static TextEditingController messageController = TextEditingController();
  static ScrollController scrollController = ScrollController();
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String receiverEmail, senderEmail;
  @override
  Widget build(BuildContext context) {
    Map<String, String> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    senderEmail = arguments[kSenderId]!;
    receiverEmail = arguments[kReceiverId]!;
    return Scaffold(
      appBar: AppBar(
        //علشان الغي الباك ارو
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            ChatPage.messageController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
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
      body:
          ChatPageBody(senderEmail: senderEmail, receiverEmail: receiverEmail),
    );
  }
}
