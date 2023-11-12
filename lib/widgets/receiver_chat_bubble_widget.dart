import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helpers/custom_edit_date_format_function.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/widgets/show_alert_dialog_widget.dart';

class ReceiverChatBubble extends StatelessWidget {
  final MessageModel bubbleMessage;

  const ReceiverChatBubble({Key? key, required this.bubbleMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onLongPress: () {
          showAlertDialog(context: context, bubbleMessage: bubbleMessage);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: kReceiverMessageColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Text(
                bubbleMessage.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                customEditDateFormatFunction(
                    dateAsString: bubbleMessage.createdAT.toDate().toString()),
                style: const TextStyle(fontSize: 8, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
