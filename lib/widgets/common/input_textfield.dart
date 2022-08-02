import 'package:flutter/material.dart';

import '../../utils/mytheme.dart';

class InputTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  bool obscureText;
  InputTextfield({
    required this.hintText,
    required this.controller,
    required this.icon,
    this.isPassword = false,
    this.obscureText = true,
    Key? key,
  }) : super(key: key);

  @override
  State<InputTextfield> createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<InputTextfield> {
  bool passwordVisible = false;

  togglePassword() {
    passwordVisible = !passwordVisible;
    widget.obscureText = !widget.obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? widget.obscureText : false,
      style: const TextStyle(color: Colors.black),
      cursorColor: MyTheme.greenColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        fillColor: MyTheme.greyColor,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(
            widget.icon,
            color: MyTheme.greenColor,
          ),
        ),
        prefixText: '  ',
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: togglePassword,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    passwordVisible ? Icons.remove_red_eye : Icons.elderly,
                    color: MyTheme.greenColor,
                    // passwordVisible ? showPassword : hidePassword,
                    // color: node.hasFocus
                    //     ? const Color(0xFFbc5590)
                    //     : Colors.grey[400],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class LabelTextField extends StatelessWidget {
  final String label;
  const LabelTextField({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 1),
        TextField(
          style: const TextStyle(color: Colors.black),
          cursorColor: MyTheme.greenColor,
          // keyboardType: TextInputType.multiline,
          // maxLines: null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              left: 15,
              bottom: 10,
              top: 10,
              right: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: MyTheme.greenColor,
              ),
            ),
            // hintText: widget.hintText,
            // hintStyle: const TextStyle(color: Colors.black45),
            fillColor: Colors.white,
            filled: true,
            // prefixIcon: Padding(
            //   padding: const EdgeInsets.only(left: 12),
            //   child: Icon(
            //     widget.icon,
            //     color: MyTheme.greenColor,
            //   ),
            // ),
            prefixText: ' ',
          ),
        ),
      ],
    );
  }
}
