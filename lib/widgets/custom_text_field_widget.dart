import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final void Function(String)? inputText;
  final TextEditingController inPutController;
  static bool obscureType = true;

  const MyFormField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.inputText,
      required this.inPutController})
      : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.inPutController,
      validator: (data) {
        if (data == null) {
          return "value can't be empty";
        } else if (data.characters.length < 8) {
          return "value cant't be less than 8 characters";
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: widget.inputText,
      
      obscureText: widget.labelText == "Password" ? MyFormField.obscureType : false,
      decoration: InputDecoration(
        suffixIcon: widget.labelText == "Password"
            ? IconButton(
                onPressed: () {
                  MyFormField.obscureType = !MyFormField.obscureType;
                  setState(() {});
                },
                icon: MyFormField.obscureType
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
