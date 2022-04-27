import 'dart:convert';
import 'dart:io';

DataModel dataModeFromJson(String str) => DataModel.fromJson(json.decode(str));

class DataModel {
  DataModel(
      {required this.testimonial_id,
      required this.user,
      required this.testimonial_descr,
      required this.testimonial_date,
      required this.status,
      required this.feedback,
      required this.user_id});

  String testimonial_id;
  String user;
  String testimonial_descr;
  String testimonial_date;
  String status;
  int feedback;
  String user_id;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        testimonial_id: json["testimonial_id"],
        user: json["user"],
        testimonial_descr: json["testimonial_descr"],
        testimonial_date: json["testimonial_date"],
        status: json["status"],
        feedback: json["feedback"],
        user_id: json["user_id"],
      );
  Map<String, dynamic> toJson() => {
        "testimonial_id": testimonial_id,
        "testimonial_descr": testimonial_descr,
        "user": user,
        "testimonial_date": testimonial_date,
        "status": status,
        "feedback": feedback,
        "user_id": user_id
      };
}
