import 'package:ultimate_demo/Screens/About/about_screen.dart';
import 'package:ultimate_demo/Screens/Login/login_screen.dart';
import 'package:ultimate_demo/Screens/Orders/orders_screen.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/utility/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String title = 'Orders';
  Widget pageToDisplay = OrdersScreen();
  int pageNum = 1;
  Api apiObj = Api();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (pageNum) {
      case 1:
        pageToDisplay = OrdersScreen();
        break;
      case 2:
        pageToDisplay = AboutScreen();
        break;
      default:
        pageToDisplay = OrdersScreen();
    }
    return Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: pageToDisplay,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Text(
                      'Welcome ' +
                          (StaticVariables.accessToken != null
                              ? StaticVariables.accessToken.userName
                              : ''),
                      style:
                          TextStyle(fontSize: 18, color: kPrimaryLightColor)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Last Login Date ' +
                          (StaticVariables.accessToken != null
                              ? StaticVariables.accessToken.lastLoginDate
                              : ''),
                      style:
                          TextStyle(fontSize: 12, color: kPrimaryLightColor)),
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      radius: 25,
                      child: Image.asset(
                        "assets/images/logo.png",
                        //height: size.height * 0.35,
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    tileColor: pageNum == 1 ? Colors.grey[400] : null,
                    title: Text(
                      'Orders',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.bar_chart),
                    onTap: () {
                      // Update the state of the app
                      setState(() {
                        pageNum = 1;
                        title = 'Orders';
                      });
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    tileColor: pageNum == 2 ? Colors.grey[400] : null,
                    title: Text('About', style: TextStyle(fontSize: 18)),
                    leading: Icon(Icons.history_outlined),
                    onTap: () {
                      // Update the state of the app
                      setState(() {
                        pageNum = 2;
                        title = 'About';
                      });
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            //SizedBox(height: size.height * 0.46),
            Center(
              child: ListTile(
                title: Text('Signout1', style: TextStyle(fontSize: 18)),
                leading: Icon(Icons.logout),
                onTap: () {
                  showAlertDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
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
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => LoginScreen()));
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
