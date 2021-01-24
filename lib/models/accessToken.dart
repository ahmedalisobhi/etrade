class AccessToken {
  String miststatus;
  String mistmessage;
  String userName;
  String accessToken;
  String accountId;
  String fullName;
  String lastLoginDate;
  String userLanguage;
  String authType;
  String firstLogin;
  double firstExpirationPeriod;
  String secondLogin;
  double secondExpirationPeriod;
  int questionId;
  String questionDesc;
  // String questionDescAr ;
  int position1;
  int position2;
  int position3;
  String position1Desc;
  String position2Desc;
  String position3Desc;
  String userType;

  AccessToken(this.accessToken, this.userName, this.accountId, this.fullName,
      this.lastLoginDate);

  factory AccessToken.fromJson(dynamic json) {
    return AccessToken(
        json['access_token'] as String,
        json['userName'] as String,
        json['AccountId'] as String,
        json['fullName'] as String,
        json['lastLoginDate'] as String);
  }

  @override
  String toString() {
    return '{ ${this.accessToken}, ${this.userName}, ${this.accountId}, ${this.fullName}, ${this.lastLoginDate} }';
  }
}
