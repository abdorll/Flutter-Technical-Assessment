class TransactionsData {
  String? _uuid;
  String? _reference;
  int? _amount;
  int? _fee;
  String? _currency;
  String? _metadata;
  String? _type;
  String? _source;
  String? _initiator;
  String? _celebrityId;
  String? _userId;
  String? _status;
  String? _failureReason;
  String? _createdAtDateOnly;
  String? _createdAt;
  User? _user;
  User? _celebrity;

  TransactionsData.fromJson({required Map<String, dynamic> json}) {
    _uuid = json['uuid'];
    _reference = json['reference'];
    _amount = json['amount'];
    _fee = json['fee'];
    _currency = json['currency'];
    _metadata = json['metadata'];
    _type = json['type'];
    _source = json['source'];
    _initiator = json['initiator'];
    _celebrityId = json['celebrityId'];
    _userId = json['userId'];
    _status = json['status'];
    _failureReason = json['failureReason'];
    _createdAtDateOnly = json['createdAtDateOnly'];
    _createdAt = json['createdAt'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _celebrity =
        json['celebrity'] != null ? User.fromJson(json['celebrity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = _uuid;
    data['reference'] = _reference;
    data['amount'] = _amount;
    data['fee'] = _fee;
    data['currency'] = _currency;
    data['metadata'] = _metadata;
    data['type'] = _type;
    data['source'] = _source;
    data['initiator'] = _initiator;
    data['celebrityId'] = _celebrityId;
    data['userId'] = _userId;
    data['status'] = _status;
    data['failureReason'] = _failureReason;
    data['createdAtDateOnly'] = _createdAtDateOnly;
    data['createdAt'] = _createdAt;
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    if (_celebrity != null) {
      data['celebrity'] = _celebrity!.toJson();
    }
    return data;
  }
}

class User {
  String? _uuid;
  String? _fullName;
  String? _userName;
  String? _occupation;
  String? _profileImagePath;
  String? _email;
  String? _dateOfBirth;
  String? _bio;
  bool? _isEmailVerified;
  String? _type;
  bool? _activeNotification;
  bool? _informationSubscription;
  String? _eligibility;
  String? _createdAtDateOnly;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _uuid = json['uuid'];
    _fullName = json['fullName'];
    _userName = json['userName'];
    _occupation = json['occupation'];
    _profileImagePath = json['profileImagePath'];
    _email = json['email'];
    _dateOfBirth = json['dateOfBirth'];
    _bio = json['bio'];
    _isEmailVerified = json['isEmailVerified'];
    _type = json['type'];
    _activeNotification = json['activeNotification'];
    _informationSubscription = json['informationSubscription'];
    _eligibility = json['eligibility'];
    _createdAtDateOnly = json['createdAtDateOnly'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uuid'] = _uuid;
    data['fullName'] = _fullName;
    data['userName'] = _userName;
    data['occupation'] = _occupation;
    data['profileImagePath'] = _profileImagePath;
    data['email'] = _email;
    data['dateOfBirth'] = _dateOfBirth;
    data['bio'] = _bio;
    data['isEmailVerified'] = _isEmailVerified;
    data['type'] = _type;
    data['activeNotification'] = _activeNotification;
    data['informationSubscription'] = _informationSubscription;
    data['eligibility'] = _eligibility;
    data['createdAtDateOnly'] = _createdAtDateOnly;
    data['status'] = _status;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
