// To parse this JSON data, do
//
//     final responseAllUser = responseAllUserFromJson(jsonString);

import 'dart:convert';

ResponseAllUser responseAllUserFromJson(String str) => ResponseAllUser.fromJson(json.decode(str));

String responseAllUserToJson(ResponseAllUser data) => json.encode(data.toJson());

class ResponseAllUser {
  ResponseAllUser({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseAllUser.fromJson(Map<String, dynamic> json) => ResponseAllUser(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseAllUser &&
          runtimeType == other.runtimeType &&
          result == other.result &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => result.hashCode ^ message.hashCode ^ data.hashCode;
}

class Data {
  Data({
    this.members,
  });

  List<Members>? members;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "members": List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Members {
  Members({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  int? id;
  String? name;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? avatar;

  factory Members.fromJson(Map<String, dynamic> json) => Members(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    designation: json["designation"],
    department: json["department"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "designation": designation,
    "department": department,
    "avatar": avatar,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Members &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          phone == other.phone &&
          email == other.email &&
          designation == other.designation &&
          department == other.department &&
          avatar == other.avatar;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      designation.hashCode ^
      department.hashCode ^
      avatar.hashCode;
}
