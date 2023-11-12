// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/messages_cubit/messages_cubit.dart';
import 'package:scholar_chat/models/user_model.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/sign_up_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPageBody extends StatelessWidget {
  final String senderEmail;

  const UsersPageBody({Key? key, required this.senderEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: SignUpPage.users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<UserModel> usersList = [];

          for (var element in snapshot.data!.docs) {
            if (UserModel.fromJson(element).email != senderEmail) {
              usersList.add(UserModel.fromJson(element));
            }
          }
          return Column(
            children: [
              Text(
                senderEmail.replaceAll(r'@gmail.com', ""),
                style: const TextStyle(
                  fontSize: 20,
                  color: kPrimaryColor,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: usersList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<MessagesCubit>(context).getMessages(
                          senderEmail: senderEmail.toString(),
                          receiverEmail: usersList[index].email.toString(),
                        );
                        Navigator.pushNamed(
                          context,
                          ChatPage.chatPageRoute,
                          arguments: {
                            kSenderId: senderEmail.toString(),
                            kReceiverId: usersList[index].email.toString(),
                          },
                        );
                      },
                      child: Container(
                        color: kPrimaryColor,
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            usersList[index]
                                .email
                                .replaceAll(r'@gmail.com', ""),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 1,
                ),
                Text(
                  "No users yet",
                  style: TextStyle(color: kPrimaryColor, fontSize: 24),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          );
        } else {
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
        }
      },
    );
  }
}
