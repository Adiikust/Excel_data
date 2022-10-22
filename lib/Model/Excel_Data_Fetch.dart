import 'dart:convert';

/// name : "kani"
/// email : 45
/// mobile_no : "df"
/// feedback : "d"

ExcelDataFetch excelDataFetchFromJson(String str) =>
    ExcelDataFetch.fromJson(json.decode(str));
String excelDataFetchToJson(ExcelDataFetch data) => json.encode(data.toJson());

class ExcelDataFetch {
  ExcelDataFetch({
    String? name,
    num? email,
    String? mobileNo,
    String? feedback,
  }) {
    _name = name;
    _email = email;
    _mobileNo = mobileNo;
    _feedback = feedback;
  }

  ExcelDataFetch.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobileNo = json['mobile_no'];
    _feedback = json['feedback'];
  }
  String? _name;
  num? _email;
  String? _mobileNo;
  String? _feedback;
  ExcelDataFetch copyWith({
    String? name,
    num? email,
    String? mobileNo,
    String? feedback,
  }) =>
      ExcelDataFetch(
        name: name ?? _name,
        email: email ?? _email,
        mobileNo: mobileNo ?? _mobileNo,
        feedback: feedback ?? _feedback,
      );
  String? get name => _name;
  num? get email => _email;
  String? get mobileNo => _mobileNo;
  String? get feedback => _feedback;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile_no'] = _mobileNo;
    map['feedback'] = _feedback;
    return map;
  }
}
