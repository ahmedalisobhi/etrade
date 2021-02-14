import 'dart:async';

import 'package:ultimate_demo/models/order.dart';

class OrdersStream {
  static StreamController<Order> _stream = StreamController.broadcast();
  Stream<Order> get orderStream => _stream.stream;
  static addToStream(order) {
    final dd = order[0];
    dd['RemainingQty'] = dd['RemainingQty'].round();
    dd['Quantity'] = dd['Quantity'].round();
    dd['OrderTypeId'] = dd['OrderTypeId'].round();
    dd['OrderId'] = dd['OrderId'].round();
    dd['ExecutionQty'] = dd['ExecutionQty'].round();

    //order.map((i) => orders.add(Order.fromJson(i)));
    //order.map((entry) => print('entry'));
    //var pOrder = Order.fromJson(order);
    //print(orders.length);
    _stream.add(Order.fromJson(dd));
  }
}
