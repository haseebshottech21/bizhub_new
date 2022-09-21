import 'package:flutter/material.dart';

import '../../utils/icons.dart';
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
    return TextFormField(
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

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.validator,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        cursorColor: MyTheme.greenColor,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: MyTheme.greyColor,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              icon,
              color: MyTheme.greenColor,
            ),
          ),
          prefixText: '  ',
        ),
      ),
    );
  }
}

class InputPasswordTextFormField extends StatelessWidget {
  const InputPasswordTextFormField({
    required this.hintText,
    required this.controller,
    required this.fontAwsomeIcon,
    required this.validator,
    required this.onPress,
    required this.obscureText,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final IconData fontAwsomeIcon;
  final Function validator;
  final Function onPress;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        onSaved: (newValue) {
          controller.text = newValue!;
        },
        validator: (value) => validator(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: MyTheme.greyColor,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              fontAwsomeIcon,
              color: MyTheme.greenColor,
            ),
          ),
          prefixText: '  ',
          suffixIcon: GestureDetector(
            onTap: () => onPress(),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                obscureText ? hidePassword : showPassword,
                color: MyTheme.greenColor,
              ),
            ),
          ),
          suffixIconColor: MyTheme.greenColor,
        ),
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


class EditLabelTextFields extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final Function validator;
  final bool isEnabled;

  const EditLabelTextFields({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isEnabled = true,
    this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15.0, color: MyTheme.greenColor),
          ),
          const SizedBox(height: 2),
          SizedBox(
            // height: 40,
            child: TextFormField(
              cursorWidth: 1.5,
              controller: controller,
              validator: (value) => passwordController == null
                  ? validator(value)
                  : validator(
                      passwordController!.text,
                      value,
                    ),
              enabled: isEnabled,
              onSaved: (newValue) {
                controller.text = newValue!;
              },
              cursorColor: Colors.black87,
              // keyboardType: inputType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                // enabled: false,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black12, width: 0.1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black54, width: 0.2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                // disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    left: 15, bottom: 11, top: 11, right: 15),
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
