import 'package:scholar_chat/constants.dart';

class UserModel {
  final String email;

  factory UserModel.fromJson(jsonData) {
    return UserModel(email: jsonData[kId]);
  }

  UserModel({
    required this.email,
  });
}
