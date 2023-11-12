import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitialState());
  List<MessageModel> messagesList = [];
  static CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  void sendMessages(
      {required String message,
      required String senderEmail,
      required String receiverEmail}) {
    messages.add({
      kMessages: message,
      kCreatedAt: DateTime.now(),
      kSenderId: senderEmail,
      kReceiverId: receiverEmail,
    });
  }

  void getMessages(
      {required String senderEmail, required String receiverEmail}) {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      log(event.size.toString());
      messagesList.clear();
      for (var element in event.docs) {
        if ((element[kSenderId].toString() == senderEmail &&
                element[kReceiverId].toString() == receiverEmail) ||
            (element[kSenderId].toString() == receiverEmail &&
                element[kReceiverId].toString() == senderEmail)) {
          messagesList.add(
            MessageModel.fromJson(jsonData: element, theMessageId: element.id),
          );
        }
      }
      log(messagesList.length.toString());
      emit(MessagesSuccessState(messagesList: messagesList));
    });
  }
}
