import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/messages_cubit/messages_cubit.dart';
import 'package:scholar_chat/helpers/custom_edit_date_format_function.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/widgets/message_text_field_widget.dart';
import 'package:scholar_chat/widgets/receiver_chat_bubble_widget.dart';
import 'package:scholar_chat/widgets/sender_chat_bubble_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatelessWidget {
  final String senderEmail, receiverEmail;
  const ChatPageBody(
      {Key? key, required this.senderEmail, required this.receiverEmail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // messagesList = messagesList.reversed.toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "your UserName => $senderEmail".replaceAll(r'@gmail.com', ""),
              style: const TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "receiver UserName => $receiverEmail"
                  .replaceAll(r'@gmail.com', ""),
              style: const TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              List<MessageModel> messagesList =
                  BlocProvider.of<MessagesCubit>(context).messagesList;
              return messagesList.isEmpty
                  ? const Center(
                      child: Text(
                        "No messages yet",
                        style: TextStyle(color: kPrimaryColor, fontSize: 24),
                      ),
                    )
                  : ListView.builder(
                      controller: ChatPage.scrollController,
                      itemCount: messagesList.length,
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        String date1 = "";
                        String date2 = "";
                        date2 = messagesList[index]
                            .createdAT
                            .toDate()
                            .day
                            .toString();
                        log("2 $date2");
                        if (index != 0) {
                          date1 = messagesList[index - 1]
                              .createdAT
                              .toDate()
                              .day
                              .toString();
                          log(date1);
                        }

                        if (messagesList[index].senderId == senderEmail) {
                          return date2 != date1
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SenderChatBubble(
                                      bubbleMessage: messagesList[index],
                                    ),
                                    Text(customDateFormatFunction(
                                        dateAsString: messagesList[index]
                                            .createdAT
                                            .toDate()
                                            .toString())),
                                  ],
                                )
                              : SenderChatBubble(
                                  bubbleMessage: messagesList[index],
                                );
                        } else {
                          return date2 != date1
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ReceiverChatBubble(
                                      bubbleMessage: messagesList[index],
                                    ),
                                    Text(customDateFormatFunction(
                                        dateAsString: messagesList[index]
                                            .createdAT
                                            .toDate()
                                            .toString())),
                                  ],
                                )
                              : ReceiverChatBubble(
                                  bubbleMessage: messagesList[index],
                                );
                        }
                      },
                    );
            },
          ),
        ),
        BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            return MessageTextField(
              senderEmail: senderEmail,
              receiverEmail: receiverEmail,
              docIsNotEmpty: state is MessagesSuccessState
                  ? state.messagesList.isNotEmpty
                  : false,
            );
          },
        )
      ],
    );
  }
}
/*
else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  "No messages yet",
                  style: TextStyle(color: kPrimaryColor, fontSize: 24),
                ),
                const Spacer(
                  flex: 1,
                ),
                MessageTextField(
                  senderEmail: senderEmail,
                  receiverEmail: receiverEmail,
                  docIsNotEmpty: snapshot.data!.docs.isNotEmpty,
                ),
              ],
            ),
          );
        } 
return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("loading..."),
              ],
            ),
          );
*/
