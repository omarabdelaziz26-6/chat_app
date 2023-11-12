import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/constants.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final String messageId;
  final Timestamp createdAT;

  factory MessageModel.fromJson(
      {required jsonData, required String theMessageId}) {
    return MessageModel(
      message: jsonData[kMessages],
      createdAT: jsonData[kCreatedAt],
      senderId: jsonData[kSenderId],
      receiverId: jsonData[kReceiverId],
      messageId: theMessageId,
    );
  }

  MessageModel({
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.createdAT,
    required this.receiverId,
  });
}
