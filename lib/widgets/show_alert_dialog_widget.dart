import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

showAlertDialog(
    {required BuildContext context,
    required final MessageModel bubbleMessage}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Cancel",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text(
      "Continue",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      FirebaseFirestore.instance
          .collection(kMessagesCollection)
          .doc(bubbleMessage.messageId)
          .delete();
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: kPrimaryColor,
    title: const Row(
      children:  [
        Text(
          "Alert",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
    icon: const Icon(
      Icons.notification_important,
      color: Colors.red,
    ),
    content: const Text(
      "Would you like to continue deleting this message ?",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
