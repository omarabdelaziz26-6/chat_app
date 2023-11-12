import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/messages_cubit/messages_cubit.dart';
import 'package:scholar_chat/helpers/out_lined_border_method.dart';
import 'package:scholar_chat/helpers/scroll_to_end_functions.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTextField extends StatelessWidget {
  final String senderEmail;
  final String receiverEmail;
  final bool docIsNotEmpty;

  const MessageTextField({
    Key? key,
    required this.senderEmail,
    required this.receiverEmail,
    required this.docIsNotEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: ChatPage.messageController,
        onSubmitted: (data) {
          BlocProvider.of<MessagesCubit>(context).sendMessages(
            message: data,
            senderEmail: senderEmail,
            receiverEmail: receiverEmail,
          );

          log(ChatPage.messageController.text);
          ChatPage.messageController.clear();
          if (docIsNotEmpty) {
            jumpScrollToEndFunction();
          }
        },
        decoration: InputDecoration(
          hintText: "Send Message",
          hintStyle: const TextStyle(color: kPrimaryColor),
          enabledBorder: outLinedBorderMethod(),
          focusedBorder: outLinedBorderMethod(),
          disabledBorder: outLinedBorderMethod(),
          suffixIcon: IconButton(
            onPressed: () {
              BlocProvider.of<MessagesCubit>(context).sendMessages(
                message: ChatPage.messageController.text,
                senderEmail: senderEmail,
                receiverEmail: receiverEmail,
              );

              ChatPage.messageController.clear();
              if (docIsNotEmpty) {
                animatedScrollToEndFunction();
              }
            },
            icon: const Icon(Icons.send),
          ),
          suffixIconColor: kPrimaryColor,
        ),
      ),
    );
  }
}
