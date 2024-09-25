// To parse this JSON data, do
//
//     final dateModel = dateModelFromJson(jsonString);

import 'dart:convert';

DateModel dateModelFromJson(String str) => DateModel.fromJson(json.decode(str));

String dateModelToJson(DateModel data) => json.encode(data.toJson());

class DateModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;

  DateModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
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
  final bool date;
  final bool unique;
  final bool required;
  final String dateFormat;

  Validations({
    required this.date,
    required this.unique,
    required this.required,
    required this.dateFormat,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        date: json["date"],
        unique: json["unique"],
        required: json["required"],
        dateFormat: json["date_format"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "unique": unique,
        "required": required,
        "date_format": dateFormat,
      };
}
