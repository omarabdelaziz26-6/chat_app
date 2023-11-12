import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

OutlineInputBorder outLinedBorderMethod() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: kPrimaryColor),
      borderRadius: BorderRadius.circular(16),
    );
  }