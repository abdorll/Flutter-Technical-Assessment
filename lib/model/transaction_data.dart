class TransactionsData {
  String? uuid;
  String? reference;
  int? amount;
  int? fee;
  String? currency;
  String? metadata;
  String? type;
  String? source;
  String? initiator;
  String? celebrityId;
  String? userId;
  String? status;
  String? failureReason;
  String? createdAtDateOnly;
  String? createdAt;
  User? user;
  User? celebrity;

  TransactionsData.fromJson({required Map<String, dynamic> json}) {
    uuid = json['uuid'];
    reference = json['reference'];
    amount = json['amount'];
    fee = json['fee'];
    currency = json['currency'];
    metadata = json['metadata'];
    type = json['type'];
    source = json['source'];
    initiator = json['initiator'];
    celebrityId = json['celebrityId'];
    userId = json['userId'];
    status = json['status'];
    failureReason = json['failureReason'];
    createdAtDateOnly = json['createdAtDateOnly'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    celebrity =
        json['celebrity'] != null ? User.fromJson(json['celebrity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['reference'] = reference;
    data['amount'] = amount;
    data['fee'] = fee;
    data['currency'] = currency;
    data['metadata'] = metadata;
    data['type'] = type;
    data['source'] = source;
    data['initiator'] = initiator;
    data['celebrityId'] = celebrityId;
    data['userId'] = userId;
    data['status'] = status;
    data['failureReason'] = failureReason;
    data['createdAtDateOnly'] = createdAtDateOnly;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (celebrity != null) {
      data['celebrity'] = celebrity!.toJson();
    }
    return data;
  }
}

class User {
  String? uuid;
  String? fullName;
  String? userName;
  String? occupation;
  String? profileImagePath;
  String? email;
  String? dateOfBirth;
  String? bio;
  bool? isEmailVerified;
  String? type;
  bool? activeNotification;
  bool? informationSubscription;
  String? eligibility;
  String? createdAtDateOnly;
  String? status;
  String? createdAt;
  String? updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    fullName = json['fullName'];
    userName = json['userName'];
    occupation = json['occupation'];
    profileImagePath = json['profileImagePath'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    type = json['type'];
    activeNotification = json['activeNotification'];
    informationSubscription = json['informationSubscription'];
    eligibility = json['eligibility'];
    createdAtDateOnly = json['createdAtDateOnly'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['occupation'] = occupation;
    data['profileImagePath'] = profileImagePath;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth;
    data['bio'] = bio;
    data['isEmailVerified'] = isEmailVerified;
    data['type'] = type;
    data['activeNotification'] = activeNotification;
    data['informationSubscription'] = informationSubscription;
    data['eligibility'] = eligibility;
    data['createdAtDateOnly'] = createdAtDateOnly;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
