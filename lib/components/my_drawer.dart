import 'package:flutter/material.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/utility/constants.dart';

class MyDrawer extends StatelessWidget {
  final int pageNum;
  MyDrawer({this.pageNum});
  final Api apiObj = Api();
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    style: TextStyle(fontSize: 18, color: kPrimaryLightColor)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Last Login Date ' +
                        (StaticVariables.accessToken != null
                            ? StaticVariables.accessToken.lastLoginDate
                            : ''),
                    style: TextStyle(fontSize: 12, color: kPrimaryLightColor)),
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
          Column(
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
                  Navigator.pushNamed(context, '/orders');
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor: pageNum == 2 ? Colors.grey[400] : null,
                title: Text('About', style: TextStyle(fontSize: 18)),
                leading: Icon(Icons.history_outlined),
                onTap: () {
                  // Update the state of the app
                  Navigator.pushNamed(context, '/about');
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              )
            ],
          ),
          //SizedBox(height: size.height * 0.46),
          Center(
            child: ListTile(
              title: Text('Signout', style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.logout),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ),
        ],
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
