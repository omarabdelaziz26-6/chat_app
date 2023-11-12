part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitialState extends MessagesState {}

class MessagesSuccessState extends MessagesState {
  final List<MessageModel> messagesList;

  MessagesSuccessState({required this.messagesList});
}
