import 'package:flutter/material.dart';
import 'package:ultimate_demo/utility/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.phone),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '19777',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        // GestureDetector(
        //   onTap: press,
        //   child: Text(
        //     login ? "Sign Up" : "Sign In",
        //     style: TextStyle(
        //       color: kPrimaryColor,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
