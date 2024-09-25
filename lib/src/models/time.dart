// To parse this JSON data, do
//
//     final timeModel = timeModelFromJson(jsonString);

import 'dart:convert';

TimeModel timeModelFromJson(String str) => TimeModel.fromJson(json.decode(str));

String timeModelToJson(TimeModel data) => json.encode(data.toJson());

class TimeModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;

  TimeModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => TimeModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        validations: Validations.fromJson(json["validations"]),
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "field_type": fieldType,
        "field_order": fieldOrder,
        "class_name": className,
        "label": label,
        "placeholder": placeholder,
        "validations": validations.toJson(),
      };
}

class Validations {
  final bool time;
  final bool unique;
  final bool required;
  final String timeFormat;

  Validations({
    required this.time,
    required this.unique,
    required this.required,
    required this.timeFormat,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        time: json["time"],
        unique: json["unique"],
        required: json["required"],
        timeFormat: json["time_format"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "unique": unique,
        "required": required,
        "time_format": timeFormat,
      };
}
