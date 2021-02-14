import 'dart:async';

class SignoutStream {
  static StreamController<String> _stream = StreamController.broadcast();
  Stream<String> get signoutStream => _stream.stream;
  static addToStream(String message) {
    _stream.add(message);
  }
}
