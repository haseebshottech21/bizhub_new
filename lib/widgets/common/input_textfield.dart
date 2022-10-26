import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/icons.dart';
import '../../utils/mytheme.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.validator,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final Function validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        cursorColor: MyTheme.greenColor,
        validator: (value) => validator(value),
        inputFormatters: inputFormatters,
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
    this.password,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextEditingController? password;
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
        validator: (value) => password == null
            ? validator(value)
            : validator(
                value!.trim(),
                password!.text.trim(),
              ),
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
  final String? hintText;
  final TextEditingController controller;
  final Function? validator;
  final bool isEnabled;
  final bool? textAreaField;
  final int? minLinesTextArea;
  final List<TextInputFormatter>? inputFormatters;
  const LabelTextField({
    required this.label,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.hintText = '',
    this.isEnabled = true,
    this.textAreaField = false,
    this.minLinesTextArea = 5,
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
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        textAreaField == false
            ? TextFormField(
                style: const TextStyle(color: Colors.black),
                cursorColor: MyTheme.greenColor,
                // keyboardType: TextInputType.multiline,
                // maxLines: null,
                validator: (value) => validator!(value),
                inputFormatters: inputFormatters,
                enabled: isEnabled,
                controller: controller,
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
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black45),
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
              )
            : TextFormField(
                style: const TextStyle(color: Colors.black),
                cursorColor: MyTheme.greenColor,
                // keyboardType: TextInputType.multiline,
                // maxLines: null,
                controller: controller,
                minLines: minLinesTextArea,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) => validator!(value),
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
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black45),
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

class UpdateLabelTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  // final Function? validator;
  final bool isEnabled;
  final bool? textAreaField;
  final int? minLinesTextArea;
  final List<TextInputFormatter>? inputFormatters;
  const UpdateLabelTextField({
    required this.label,
    required this.controller,
    // this.validator,
    this.inputFormatters,
    this.hintText = '',
    this.isEnabled = true,
    this.textAreaField = false,
    this.minLinesTextArea = 5,
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
        textAreaField == false
            ? TextFormField(
                style: const TextStyle(color: Colors.black),
                cursorColor: MyTheme.greenColor,
                // keyboardType: TextInputType.multiline,
                // maxLines: null,
                // validator: (value) => validator!(value),
                inputFormatters: inputFormatters,
                enabled: isEnabled,
                controller: controller,
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
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black45),
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
              )
            : TextFormField(
                style: const TextStyle(color: Colors.black),
                cursorColor: MyTheme.greenColor,
                // keyboardType: TextInputType.multiline,
                // maxLines: null,
                controller: controller,
                minLines: minLinesTextArea,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // validator: (value) => validator!(value),
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
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black45),
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
