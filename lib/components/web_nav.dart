import 'package:flutter/material.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/utility/constants.dart';

// ignore: must_be_immutable
class WebNav extends StatefulWidget {
  double opacity = 0;
  int pageNum = 1;

  WebNav(this.pageNum);

  @override
  _WebNavState createState() => _WebNavState();
}

class _WebNavState extends State<WebNav> {
  // final List _isHovering = [
  //   false,
  //   false,
  // ];
  final Api apiObj = Api();
  TextStyle selectedTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return !SizeParam.isSmallScreen(context)
        ? PreferredSize(
            preferredSize: Size(screenSize.width, 1000),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.grey),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 80,
                      width: 500,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 65,
                            ),
                            radius: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  (StaticVariables.accessToken != null
                                      ? StaticVariables.accessToken.userName
                                      : 'shark'),
                                  style: TextStyle(
                                      fontSize: 18, color: kPrimaryLightColor)),
                              Text(
                                  'Last Login Date ' +
                                      (StaticVariables.accessToken != null
                                          ? StaticVariables
                                              .accessToken.lastLoginDate
                                          : ''),
                                  style: TextStyle(
                                      fontSize: 12, color: kPrimaryLightColor)),
                            ],
                          )
                        ],
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        child: Row(
                          children: [
                            //Icon(Icons.logout),
                            Text(
                              'Orders',
                              style: widget.pageNum == 1
                                  ? selectedTextStyle
                                  : TextStyle(
                                      fontSize: 18,
                                    ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/orders');
                        },
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      InkWell(
                          child: Row(
                            children: [
                              //Icon(Icons.history_outlined),
                              Text(
                                'About',
                                style: widget.pageNum == 2
                                    ? selectedTextStyle
                                    : TextStyle(
                                        fontSize: 18,
                                      ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/about');
                          }),
                      SizedBox(
                        width: 60,
                      ),
                      RaisedButton.icon(
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          icon: Icon(Icons.logout),
                          label: Text('Signout'))
                    ],
                  )
                ],
              ),
            ))
        : Container();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = FlatButton(
      child: Text("YES"),
      onPressed: () async {
        // Then close the drawer
        Navigator.pop(context);
        // Update the state of the app
        Navigator.pushNamed(context, '/login');
        //call Logout
        await apiObj.postData('api/account/logout');
        StaticVariables.accessToken = null;
        StaticVariables.basicData = null;
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
