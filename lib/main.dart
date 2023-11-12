import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/bloc_observer.dart';
import 'package:scholar_chat/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/cubits/log_bloc/log_bloc.dart';
import 'package:scholar_chat/cubits/messages_cubit/messages_cubit.dart';
import 'package:scholar_chat/firebase/firebase_options.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/log_in_page.dart';
import 'package:scholar_chat/pages/sign_up_page.dart';
import 'package:scholar_chat/pages/users_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserver1();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => MessagesCubit(),
        ),
        BlocProvider(
          create: (context) => LogBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LogInPage.loIngRoute: (context) => const LogInPage(),
          SignUpPage.signUpRoute: (context) => const SignUpPage(),
          ChatPage.chatPageRoute: (context) => const ChatPage(),
          UserPage.userPageRoute: (context) => const UserPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LogInPage.loIngRoute,
      ),
    );
  }
}
