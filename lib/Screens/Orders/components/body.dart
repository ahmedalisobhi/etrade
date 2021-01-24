import 'package:ultimate_demo/Screens/Orders/components/order_listTile.dart';
import 'package:ultimate_demo/components/web_nav.dart';
import 'package:ultimate_demo/models/order.dart';
import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Order> ordersp = <Order>[];
  List<Order> ordersf = <Order>[];
  List<Order> ordersc = <Order>[];
  bool isLoading = false;
  int currentIndex = 0;
  Api apiObj = Api();
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData('P'));
  }

  Future loadData(String status) async {
    dynamic data = await apiObj.getData('/api/Orders/GetTodayOrders/' +
        ((StaticVariables.accessToken != null
            ? StaticVariables.accessToken.accountId
            : "0")) +
        '/' +
        '$status' +
        '/1');

    if (data['success'] == true) {
      var ordersData = data['data'];
      //List<Order> list = List<Order>();
      // ordersData.map((doc) {
      //   list.add(Order.fromJson(doc));
      // }).toList();
      setState(() {
        ordersData.map((doc) {
          switch (status) {
            case 'P':
              ordersp.add(Order.fromJson(doc));
              break;
            case 'F':
              ordersf.add(Order.fromJson(doc));
              break;
            case 'C':
              ordersc.add(Order.fromJson(doc));
              break;
            default:
          }
        }).toList();
        //_orders = list;
      });
    }
  }

  void _handleTabSelection() async {
    if (_tabController.indexIsChanging ||
        _tabController.index != this.currentIndex) {
      switch (_tabController.index) {
        case 0:
          //load opened orders
          if (ordersp.length == 0) {
            setState(() {
              isLoading = true;
              currentIndex = 0;
            });
            await this.loadData('P');
            setState(() {
              isLoading = false;
            });
          } else
            setState(() {
              currentIndex = 0;
            });
          break;
        case 1:
          //load executed orders
          if (ordersf.length == 0) {
            setState(() {
              isLoading = true;
              currentIndex = 1;
            });
            await this.loadData('F');
            setState(() {
              isLoading = false;
            });
          } else
            setState(() {
              currentIndex = 1;
            });
          break;
        case 2:
          if (ordersc.length == 0) {
            setState(() {
              isLoading = true;
              currentIndex = 2;
            });
            //load cancelled orders
            await this.loadData('C');
            setState(() {
              isLoading = false;
            });
          } else
            setState(() {
              currentIndex = 2;
            });
          break;
      }
    }
  }

  List<DataColumn> _getDataColumn() {
    return <DataColumn>[
      DataColumn(
        label: Text(
          '',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Type',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Stock Name',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Order',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Quantity',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Price',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Executed',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Date',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Valid Till',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Book Keeper',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ];
  }

  List<DataRow> _getDataRow(List<Order> listOfData) {
    List<DataRow> rows = [];

    listOfData.forEach((row) {
      rows.add(DataRow(cells: <DataCell>[
        DataCell(Icon(Icons.swap_horiz)),
        DataCell(Text(row.orderTypeId == 1 ? 'Buy' : 'Sell')),
        DataCell(Text(row.stockName)),
        DataCell(Text(row.orderId.toString())),
        DataCell(Text(row.quantity.toString())),
        DataCell(Text(row.price.toString())),
        DataCell(Text(row.executionQty.toString())),
        DataCell(Text(row.orderDate)),
        DataCell(Text(row.dateLimit)),
        DataCell(Text(row.bKeeper)),
      ]));
    });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WebNav(1),
        // the tab bar with two items
        Container(
          padding: EdgeInsets.all(SizeParam.isSmallScreen(context) ? 0 : 10),
          child: SizedBox(
            height: 50,
            child: AppBar(
              bottom: TabBar(
                indicatorColor: kPrimaryLightColor,
                controller: _tabController,
                tabs: [
                  Tab(
                    //text: 'Open',
                    child: Text(
                      'Open',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Tab(
                      child: Text(
                    'Executed',
                    style: TextStyle(fontSize: 16),
                  )),
                  Tab(
                    child: Text(
                      'Cancelled',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // create widgets for each tab bar here
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // first tab bar view widget
              // isLoading
              //     ? Center(child: CircularProgressIndicator()):
              (ordersp.length > 0
                  /*switch web or mobile*/ ? (SizeParam.isSmallScreen(
                              context) ||
                          !kIsWeb
                      ? ((ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                                endIndent: 50,
                                indent: 50,
                              ),
                          itemCount: ordersp.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            return OrderListTile(order: ordersp[index]);
                          })))
                      : SingleChildScrollView(
                          child: (DataTable(
                            columns: _getDataColumn(),
                            rows: _getDataRow(ordersp),
                          )),
                        ))
                  : (Center(
                      child: Text('No data to display'),
                    ))),

              // second tab bar viiew widget
              ordersf.length > 0
                  ? (!kIsWeb
                      ? (ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                                endIndent: 50,
                                indent: 50,
                              ),
                          itemCount: ordersf.length,
                          itemBuilder: (context, index) {
                            return OrderListTile(order: ordersf[index]);
                          }))
                      : (DataTable(
                          columns: _getDataColumn(),
                          rows: _getDataRow(ordersf),
                        )))
                  : (Center(
                      child: Text('No data to display'),
                    )),

              // third tab bar viiew widget
              ordersc.length > 0
                  ? (!kIsWeb
                      ? (ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                                endIndent: 50,
                                indent: 50,
                              ),
                          itemCount: ordersc.length,
                          itemBuilder: (context, index) {
                            return OrderListTile(order: ordersc[index]);
                          }))
                      : (DataTable(
                          columns: _getDataColumn(),
                          rows: _getDataRow(ordersc),
                        )))
                  : (Center(
                      child: Text('No data to display'),
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
