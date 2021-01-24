import 'package:flutter/material.dart';
import 'package:ultimate_demo/components/text_field_container.dart';
import 'package:ultimate_demo/utility/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText, text;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: text,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
