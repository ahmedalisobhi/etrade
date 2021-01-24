import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class Encryption {
  static String encrypt(String plainText, String password) {
    plainText = 'TEA3TR@De1142';
    password = 'TEA3TR@De1142';
    String encryptedString = '';
    var nonce = Uint8List.fromList([
      0x49,
      0x76,
      0x61,
      0x6e,
      0x20,
      0x4d,
      0x65,
      0x64,
      0x76,
      0x65,
      0x64,
      0x65,
      0x76,
      0x78,
      0x21,
      0x22
    ]);

    // var dd = sha256.convert(utf.encode(fortunaKey));
    // var aesEncrypter = AesCrypt(
    //     key: sha256.convert(utf8.encode(fortunaKey)).toString(),
    //     padding: PaddingAES
    //         .pkcs7); //generate AES encrypter with key and PKCS7 padding
    // String encWord = "";
    try {
      //final ppd = sha1.convert(utf8.encode(password));
      final key = Key.fromLength(32);
      final iv = IV.fromUtf8(String.fromCharCodes(nonce));

      final encrypter = Encrypter(AES(key));

      encryptedString = encrypter.encrypt(plainText, iv: iv).base64;

      // encWord = aesEncrypter.gcm.encrypt(
      //     inp: base64.encode(utf8.encode(password)),
      //     iv: base64.encode(utf8.encode(String.fromCharCodes(nonce))));
      // print(encWord);
    } catch (e) {
      print('err: $e');
    }
//encrypt using GCM
    return encryptedString;
  }
}
