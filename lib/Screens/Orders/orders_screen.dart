import 'package:flutter/material.dart';
import 'package:ultimate_demo/components/my_drawer.dart';
import 'package:ultimate_demo/utility/constants.dart';

import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: SizeParam.isSmallScreen(context)
          ? AppBar(
              title: Text('Orders'),
            )
          : null,
      drawer: SizeParam.isSmallScreen(context) ? MyDrawer(pageNum: 1) : null,
    );
  }
}
