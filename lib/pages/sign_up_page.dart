import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/helpers/show_snack_bar.dart';
import 'package:scholar_chat/pages/users_page.dart';
import 'package:scholar_chat/widgets/custom_bottom_widget.dart';
import 'package:scholar_chat/widgets/custom_text_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static String signUpRoute = "SignUpPage";
  static CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);

  static TextEditingController passwordInPutController =
      TextEditingController();
  static TextEditingController emailInPutController = TextEditingController();
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? emailInput, passwordInput;
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return
        // ModalProgressHUD(
        //   inAsyncCall: isLoading,
        //   child:
        BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          BlocProvider.of<AuthCubit>(context).signUpIsLoading = true;
        } else if (state is SignUpSuccessState) {
          BlocProvider.of<AuthCubit>(context).signUpIsLoading = false;
          MyFormField.obscureType = true;
          showSnackBarFunction(
            context,
            snackBarText: "Sign up progress is success",
          );
          Navigator.pushNamed(
            context,
            UserPage.userPageRoute,
            arguments: SignUpPage.emailInPutController.text,
          );
          SignUpPage.emailInPutController.clear();
          SignUpPage.passwordInPutController.clear();
        } else if (state is SignUpFailureState) {
          BlocProvider.of<AuthCubit>(context).signUpIsLoading = false;
          showSnackBarFunction(
            context,
            snackBarText: state.err,
          );
          // log(state.err);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: signUpFormKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    kLogo,
                    height: 120,
                    // width: 140,
                    // fit: BoxFit.fill,
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
                    "Sign Up",
                    textAlign: TextAlign.left,
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
                    inPutController: SignUpPage.emailInPutController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyFormField(
                    labelText: "Password",
                    hintText: "Password1234",
                    inputText: (value) => passwordInput = value,
                    inPutController: SignUpPage.passwordInPutController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonChild:
                        BlocProvider.of<AuthCubit>(context).signUpIsLoading ==
                                true
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF335068),
                                ),
                              ),
                    buttonText: "Sign Up",
                    buttonFunction: () async {
                      // log(emailInput ?? "");
                      // log(passwordInput ?? "");
                      if (signUpFormKey.currentState!.validate()) {
                        await BlocProvider.of<AuthCubit>(context)
                            .signUpFunction(
                                emailInput: emailInput,
                                passwordInput: passwordInput);
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
                        "Already have an account ?    ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            MyFormField.obscureType = true;
                          });
                          Navigator.pop(context);
                          SignUpPage.emailInPutController.clear();
                          SignUpPage.passwordInPutController.clear();
                        },
                        child: const Text(
                          "Log In",
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
          // ),
        );
      },
    );
  }
}
