class Order {
  String stockName;
  int remainingQty;
  int quantity;
  double price;
  int orderTypeId;
  String orderType;
  String orderStatusName;
  String orderState;
  int orderId;
  String orderDate;
  int executionQty;
  String dateLimit;
  String bKeeper;
  String type;
  String typeHint;

  Order(
      this.stockName,
      this.remainingQty,
      this.quantity,
      this.price,
      this.orderTypeId,
      this.orderType,
      this.orderStatusName,
      this.orderState,
      this.orderId,
      this.orderDate,
      this.executionQty,
      this.dateLimit,
      this.bKeeper,
      this.type,
      this.typeHint);

  factory Order.fromJson(dynamic json) {
    return Order(
        json['StockName'] as String,
        json['RemainingQty'] as int,
        json['Quantity'] as int,
        json['Price'] as double,
        json['OrderTypeId'] as int,
        json['OrderType'] as String,
        json['orderStatusName'] as String,
        json['OrderState'] as String,
        json['OrderId'] as int,
        json['OrderDate'] as String,
        json['ExecutionQty'] as int,
        json['DateLimit'] as String,
        json['BKeeper'] as String,
        json['Type'] as String,
        json['TypeHint'] as String);
  }

  @override
  String toString() {
    return '{ ${this.stockName}, ${this.remainingQty}, ${this.quantity},${this.price}, ${this.orderTypeId},${this.orderType}${this.orderStatusName}, ${this.orderState}, ${this.orderId}${this.orderDate}, ${this.executionQty},${this.dateLimit}${this.bKeeper}, ${this.type}, ${this.typeHint} }';
  }
}
