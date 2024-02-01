


class ReferralModel {
  ReferralModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  ReferralModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    required this.referrals,});

  Data.fromJson(dynamic json) {
    if (json['referrals'] != null) {
      referrals = [];
      json['referrals'].forEach((v) {
        referrals.add(Referrals.fromJson(v));
      });
    }
  }

  late List<Referrals> referrals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referrals'] = referrals.map((v) => v.toJson()).toList();
    return map;
  }

}


class Referrals {
  Referrals({
    required this.id,
    required this.username,
    required this.level,});

  Referrals.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    level = json['level'].toString();
  }
  late int id;
  late String username;
  late String level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['level'] = level;
    return map;
  }

}






class Message {
  Message({
    List<String>? success,
    List<String>? error,
  }){
    _success = success;
    _error=error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ?[json['success'].toString()]:null;
    _error = json['error'] != null ? [json['error'].toString()] :null;
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }

}