import 'package:flutter/material.dart';
import 'package:ultimate_demo/Screens/About/about_screen.dart';
import 'package:ultimate_demo/Screens/Home/home_screen.dart';
import 'package:ultimate_demo/Screens/Login/login_screen.dart';
import 'package:ultimate_demo/Screens/Orders/orders_screen.dart';
import 'package:ultimate_demo/utility/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/orders': (context) => OrdersScreen(),
        '/about': (context) => AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Ultimate',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      //home: LoginScreen(),
    );
  }
}
