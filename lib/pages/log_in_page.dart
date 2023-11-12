import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
// import 'package:scholar_chat/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/cubits/log_bloc/log_bloc.dart';
import 'package:scholar_chat/helpers/show_snack_bar.dart';
import 'package:scholar_chat/pages/sign_up_page.dart';
import 'package:scholar_chat/pages/users_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/widgets/custom_bottom_widget.dart';
import 'package:scholar_chat/widgets/custom_text_field_widget.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  static String loIngRoute = "LogInPage";
  static TextEditingController passwordInPutController =
      TextEditingController();
  static TextEditingController emailInPutController = TextEditingController();

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String? emailInput, passwordInput;

  GlobalKey<FormState> logInFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // return BlocListener<AuthCubit, AuthState>(
    return BlocListener<LogBloc, LogState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          BlocProvider.of<LogBloc>(context).loginIsLoading = true;
        } else if (state is LoginSuccessState) {
          MyFormField.obscureType = true;
          Navigator.pushNamed(
            context,
            UserPage.userPageRoute,
            arguments: LogInPage.emailInPutController.text,
          );
          LogInPage.emailInPutController.clear();
          LogInPage.passwordInPutController.clear();
          BlocProvider.of<LogBloc>(context).loginIsLoading = false;
        } else if (state is LoginFailureState) {
          BlocProvider.of<LogBloc>(context).loginIsLoading = false;
          showSnackBarFunction(
            context,
            snackBarText: state.err,
          );
          // log(state.err);
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: logInFormKey,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  kLogo,
                  height: 120,
                ),
                const Text(
                  "Scholar Chat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    fontFamily: "pacifico",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyFormField(
                  labelText: "Email",
                  hintText: "name@email.com",
                  inputText: (value) => emailInput = value,
                  inPutController: LogInPage.emailInPutController,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyFormField(
                  labelText: "Password",
                  hintText: "Password1234",
                  inputText: (value) => passwordInput = value,
                  inPutController: LogInPage.passwordInPutController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonChild: BlocBuilder<LogBloc, LogState>(
                    builder: (context, state) {
                      return BlocProvider.of<LogBloc>(context).loginIsLoading ==
                              true
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF335068),
                              ),
                            );
                    },
                  ),
                  buttonFunction: () async {
                    // log(emailInput ?? "");
                    // log(passwordInput ?? "");
                    if (logInFormKey.currentState!.validate()) {
                      logInFormKey.currentState!.save();
                      BlocProvider.of<LogBloc>(context).add(LoginEvents(
                          emailInput: emailInput,
                          passwordInput: passwordInput));
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?      ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpPage.signUpRoute);
                        setState(() {
                          MyFormField.obscureType = true;
                        });
                        LogInPage.emailInPutController.clear();
                        LogInPage.passwordInPutController.clear();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFFC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
