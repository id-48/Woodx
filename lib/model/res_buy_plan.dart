// To parse this JSON data, do
//
//     final resBuyPlan = resBuyPlanFromJson(jsonString);

import 'dart:convert';

ResBuyPlan resBuyPlanFromJson(String str) => ResBuyPlan.fromJson(json.decode(str));

String resBuyPlanToJson(ResBuyPlan data) => json.encode(data.toJson());

class ResBuyPlan {
  String message;
  Data data;

  ResBuyPlan({
    required this.message,
    required this.data,
  });

  factory ResBuyPlan.fromJson(Map<String, dynamic> json) => ResBuyPlan(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String url;
  String paymentId;

  Data({
    required this.url,
    required this.paymentId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
        paymentId: json["payment_id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "payment_id": paymentId,
      };
}
