import 'package:flutter/material.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: () async => false, child: Body());
  }
}
