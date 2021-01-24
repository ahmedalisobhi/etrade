import 'package:ultimate_demo/models/order.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListTile extends StatelessWidget {
  final Order order;
  OrderListTile({this.order});
  final fdecimal = new NumberFormat("#,##0.000", "en_US");
  final fint = new NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
        header: ListTile(
          leading: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.addchart,
                    //color: Colors.orange,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  '${order.orderType}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          (order.orderTypeId == 1 ? Colors.green : Colors.red),
                      fontSize: 8),
                ),
              )
            ],
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Order #${order.orderId} - ${order.stockName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (order.price != null
                              ? '${fdecimal.format(order.price)}'
                              : 'Market'),
                          style: TextStyle(fontSize: 17),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            'PRICE',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${fint.format(order.quantity)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            'QUANTITY',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${fint.format(order.executionQty)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            'EXECUTED',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        expanded: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.orderDate}',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'DATE',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.dateLimit}',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'VALID TILL',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${order.bKeeper}',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'BOOK KEEPER',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
