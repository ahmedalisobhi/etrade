import 'package:flutter/material.dart';
import 'package:ultimate_demo/components/web_nav.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/utility/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userName = '', password = '';
  final apiObj = Api();
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(
          10, (SizeParam.isSmallScreen(context) ? 70 : 0), 10, 20),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WebNav(2),
              Container(
                  padding: EdgeInsets.only(top: 350),
                  child: Center(
                      child: Text(
                    'About Page',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
