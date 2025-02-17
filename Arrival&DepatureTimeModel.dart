// To parse this JSON data, do
//
//     final arrivalDepatureTimeModel = arrivalDepatureTimeModelFromJson(jsonString);

import 'dart:convert';

ArrivalDepatureTimeModel arrivalDepatureTimeModelFromJson(String str) => ArrivalDepatureTimeModel.fromJson(json.decode(str));

String arrivalDepatureTimeModelToJson(ArrivalDepatureTimeModel data) => json.encode(data.toJson());

class ArrivalDepatureTimeModel {
  bool? success;
  String? message;
  List<Datum>? data;

  ArrivalDepatureTimeModel({
    this.success,
    this.message,
    this.data,
  });

  factory ArrivalDepatureTimeModel.fromJson(Map<String, dynamic> json) => ArrivalDepatureTimeModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? deviceId;
  String? geofenceName;
  Status? status;
  DateTime? createdAt;
  int? v;

  Datum({
    this.id,
    this.deviceId,
    this.geofenceName,
    this.status,
    this.createdAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    deviceId: json["deviceId"],
    geofenceName: json["geofenceName"],
    status: statusValues.map[json["status"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "deviceId": deviceId,
    "geofenceName": geofenceName,
    "status": statusValues.reverse[status],
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

enum Status {
  ENTERED,
  EXITED
}

final statusValues = EnumValues({
  "Entered": Status.ENTERED,
  "Exited": Status.EXITED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
