import 'package:flutter/material.dart';
import 'package:ultimate_demo/Screens/Login/components/body.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget widToDisplay = Center(
    child: SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.white : Colors.black87,
          ),
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  loadWidget() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      widToDisplay = Body();
    });
  }
}
