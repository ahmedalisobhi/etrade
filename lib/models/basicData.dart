class BasicData {
  String systemData;
  int brokerId;
  int hotLine;

  BasicData(this.systemData, this.brokerId, this.hotLine);

  factory BasicData.fromJson(dynamic json) {
    return BasicData(json['SystemData'] as String, json['BrokerId'] as int,
        json['HotLine'] as int);
  }

  @override
  String toString() {
    return '{ ${this.systemData}, ${this.brokerId}, ${this.hotLine} }';
  }
}
