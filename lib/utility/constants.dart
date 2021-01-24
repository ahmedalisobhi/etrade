import 'package:flutter/material.dart';

import '../models/accessToken.dart';
import '../models/basicData.dart';

const kPrimaryColor = Color(0xff303030);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const String apiUrl = 'https://192.168.69.37/etrade.servicenew';

class StaticVariables {
  static BasicData basicData;
  static AccessToken accessToken;
}

class SizeParam {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 500;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 500;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.width < 1200;
  }
}
