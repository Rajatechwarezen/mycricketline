
import 'dart:convert';

Blogs blogsFromMap(String str) => Blogs.fromMap(json.decode(str));

String blogsToMap(Blogs data) => json.encode(data.toMap());

class Blogs {
    String? message;
    int? success;
    List<Datum>? data;

    Blogs({
        this.message,
        this.success,
        this.data,
    });

    factory Blogs.fromMap(Map<String, dynamic> json) => Blogs(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    int? id;
    String? blTitle;
    String? blDesc;
    String? blImg;
    DateTime? createdOn;
    DateTime? modifyOn;

    Datum({
        this.id,
        this.blTitle,
        this.blDesc,
        this.blImg,
        this.createdOn,
        this.modifyOn,
    });

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        blTitle: json["bl_title"],
        blDesc: json["bl_desc"],
        blImg: json["bl_img"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        modifyOn: json["modify_on"] == null ? null : DateTime.parse(json["modify_on"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "bl_title": blTitle,
        "bl_desc": blDesc,
        "bl_img": blImg,
        "created_on": createdOn?.toIso8601String(),
        "modify_on": modifyOn?.toIso8601String(),
    };
}
