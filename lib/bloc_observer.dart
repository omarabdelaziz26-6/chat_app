import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserver1 implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // debugPrint("${change.currentState} ==>>> ${change.nextState}");
      log(change.toString());
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint(bloc.state.toString());
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint(bloc.state.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {
    log(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(transition.toString());
  }
}
