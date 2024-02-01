
class ImageShotData {
  final dynamic id;
  final dynamic image;
  late final dynamic userslike;
  final dynamic usershare;
  final dynamic userstatus;

  ImageShotData({
    required this.id,
    required this.image,
    required this.userslike,
    required this.usershare,
    required this.userstatus,
  });

  factory ImageShotData.fromJson(Map<String, dynamic> json) {
    return ImageShotData(
      id: json['id'] ?? "-",
      image: json['image'] ?? "-",
      userslike: json['userslike'] ?? "-",
      usershare: json['usershare'] ?? "-",
      userstatus: json['userstatus'] ?? "-",
    );
  }
}


// To parse this JSON data, do
//
//     final imageShotData = imageShotDataFromMap(jsonString);

// import 'dart:convert';

// ImageShotData imageShotDataFromMap(String str) => ImageShotData.fromMap(json.decode(str));

// String imageShotDataToMap(ImageShotData data) => json.encode(data.toMap());

// class ImageShotData {
//     String? message;
//     int? success;
//     List<Datum>? data;

//     ImageShotData({
//         this.message,
//         this.success,
//         this.data,
//     });

//     factory ImageShotData.fromMap(Map<String, dynamic> json) => ImageShotData(
//         message: json["message"],
//         success: json["success"],
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "message": message,
//         "success": success,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
//     };
// }

// class Datum {
//     int? id;
//     String? image;
//     int? userslike;
//     int? usershare;
//     int? userstatus;
//     DateTime? createdOn;
//     DateTime? modifyOn;

//     Datum({
//         this.id,
//         this.image,
//         this.userslike,
//         this.usershare,
//         this.userstatus,
//         this.createdOn,
//         this.modifyOn,
//     });

//     factory Datum.fromMap(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         image: json["image"],
//         userslike: json["userslike"],
//         usershare: json["usershare"],
//         userstatus: json["userstatus"],
//         createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
//         modifyOn: json["modify_on"] == null ? null : DateTime.parse(json["modify_on"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "image": image,
//         "userslike": userslike,
//         "usershare": usershare,
//         "userstatus": userstatus,
//         "created_on": createdOn?.toIso8601String(),
//         "modify_on": modifyOn?.toIso8601String(),
//     };
// }
