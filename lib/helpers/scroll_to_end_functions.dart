import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';

Future<void> animatedScrollToEndFunction() {
    return ChatPage.scrollController.animateTo(
      0,
      duration: const Duration(microseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void jumpScrollToEndFunction() {
    return ChatPage.scrollController.jumpTo(
      0,
    );
  }
