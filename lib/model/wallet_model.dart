// ignoreforfile: unusedfield

class WalletModel {
  String? uuid;
  int? balance;
  String? userId;
  String? celebrityId;
  String? currency;
  String? createdAt;

  WalletModel.fromJson({required Map<String, dynamic> json}) {
    uuid = json['uuid'];
    balance = json['balance'];
    userId = json['userId'];
    celebrityId = json['celebrityId'];
    currency = json['currency'];
    createdAt = json['createdAt'];
  }
}
