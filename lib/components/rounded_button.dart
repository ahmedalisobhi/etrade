import 'package:flutter/material.dart';
import 'package:ultimate_demo/utility/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final RoundedLoadingButtonController _btnController =
    new RoundedLoadingButtonController();

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color = kPrimaryColor,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: RoundedLoadingButton(
            controller: _btnController,
            color: color,
            onPressed: () async {
              try {
                await press();
              } catch (e) {}
              _btnController.reset();
            },
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
