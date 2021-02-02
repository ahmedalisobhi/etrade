import 'package:ultimate_demo/utility/api.dart';
import 'package:ultimate_demo/models/basicData.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'encrypt.dart';

Future<String> getGeneratedKey() async {
  if (StaticVariables.basicData == null ||
      StaticVariables.basicData.systemData.isEmpty) {
    var api = Api();
    Map data = await api.getData('/api/basicdata/getbasicinfo',
        ignoreGeneratedKey: true);
    if (data != null && data['success'] == true) {
      BasicData basicData = BasicData.fromJson(data['data']);
      if (basicData != null) {
        StaticVariables.basicData = basicData;
      }
    }
  }
  if (StaticVariables.basicData != null) {
    DateTime systemDate = new DateFormat("dd-MM-yyyy HH:mm:ss")
        .parse(StaticVariables.basicData.systemData);

    int timeDifference = DateTime.now().difference(systemDate).inSeconds;
    DateTime curDate =
        DateTime.now().add(Duration(seconds: (timeDifference * -1)));
    return Encryption.encrypt(
        _generatePassword(curDate.minute, curDate.day, curDate.month),
        _generateKey(curDate.minute, StaticVariables.basicData.brokerId));
  }
  return '';
}

String _generatePassword(int minute, int day, int month) {
  if (minute % 5 == 0) {
    return "TEA" + (minute + day + month).toString() + "3TR@De";
  } else if (minute % 3 == 0) {
    return "3TR@De" + ((minute + day + month)).toString() + "TEA";
  } else if (minute % 2 == 0) {
    return "TEA" + "3TR@De" + ((minute + day + month)).toString();
  } else
    return "3TR@De" + "TEA" + ((minute + day + month)).toString();
}

String _generateKey(int minute, int brokerId) {
  if (minute % 5 == 0) {
    return "TEA" + (brokerId).toString() + "3TR@De";
  } else if (minute % 3 == 0) {
    return "3TR@De" + (brokerId).toString() + "TEA";
  } else if (minute % 2 == 0) {
    return "TEA" + "3TR@De" + (brokerId).toString();
  } else
    return "3TR@De" + "TEA" + (brokerId).toString();
}
