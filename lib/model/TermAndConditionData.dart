class PrivacyPolicy {
  int id;
  String ppolicy;
  DateTime createdOn;
  DateTime modifyOn;

  PrivacyPolicy({
    required this.id,
    required this.ppolicy,
    required this.createdOn,
    required this.modifyOn,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicy(
      id: json['id'],
      ppolicy: json['ppolicy'],
      createdOn: DateTime.parse(json['created_on']),
      modifyOn: DateTime.parse(json['modify_on']),
    );
  }
}

//"Terms and Conditions",

class TermsAndConditions {
  int id;
  String ppolicy;
  DateTime createdOn;
  DateTime modifyOn;

  TermsAndConditions({
    required this.id,
    required this.ppolicy,
    required this.createdOn,
    required this.modifyOn,
  });

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      id: json['id'],
      ppolicy: json['termandc'],
      createdOn: DateTime.parse(json['created_on']),
      modifyOn: DateTime.parse(json['modify_on']),
    );
  }
}

//

class About {
  int id;
  String ppolicy;
  DateTime createdOn;
  DateTime modifyOn;

  About({
    required this.id,
    required this.ppolicy,
    required this.createdOn,
    required this.modifyOn,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      id: json['id'],
      ppolicy: json['about_us'],
      createdOn: DateTime.parse(json['created_on']),
      modifyOn: DateTime.parse(json['modify_on']),
    );
  }
}
