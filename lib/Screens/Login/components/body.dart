import 'package:ultimate_demo/Screens/Home/home_screen.dart';
import 'package:ultimate_demo/components/show_dialog.dart';
import 'package:ultimate_demo/models/accessToken.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/components/already_have_an_account_acheck.dart';
import 'package:ultimate_demo/components/rounded_button.dart';
import 'package:ultimate_demo/components/rounded_input_field.dart';
import 'package:ultimate_demo/components/rounded_password_field.dart';
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
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        decoration: !SizeParam.isSmallScreen(context)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(.1)))
            : null,
        padding: EdgeInsets.fromLTRB(10, 70, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   "LOGIN",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: size.height * 0.03),
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 70,
                child: Image.asset(
                  "assets/images/logo.png",
                  //height: size.height * 0.35,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "User Name",
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                text: userName,
              ),
              RoundedPasswordField(onChanged: (value) {
                setState(() {
                  password = value;
                });
              }),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  if (userName.trim() == '' || password.trim() == '') {
                    // Scaffold.of(context).showSnackBar(SnackBar(
                    //   content: Text('Invalid username or password'),
                    // ));
                    showDialogMessage('Invalid username or password');
                  } else {
                    String reqBody =
                        'username=$userName&password=$password&grant_type=password&version=21.0101.1&SymbolType=ANDROID&AppSymbol=MOBILE';
                    dynamic data =
                        await apiObj.postData('token', body: reqBody);
                    if (data['success'] == true) {
                      AccessToken accessToken =
                          AccessToken.fromJson(data['data']);
                      StaticVariables.accessToken = accessToken;
                      //navigate to home page
                      Navigator.pushNamed(context, '/orders');
                    }
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {},
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Developed by TEA Computers',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
