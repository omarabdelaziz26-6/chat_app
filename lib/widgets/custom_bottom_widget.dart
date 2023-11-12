import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Widget buttonChild;
  final void Function()? buttonFunction;

  const CustomButton({Key? key,  this.buttonText, required this.buttonChild, this.buttonFunction}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
      ),
      onPressed: buttonFunction,
      child: buttonChild,
    );
  }
}
