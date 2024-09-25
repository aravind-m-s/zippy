// To parse this JSON data, do
//
//     final hiddenModel = hiddenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HiddenModel hiddenModelFromJson(String str) =>
    HiddenModel.fromJson(json.decode(str));

String hiddenModelToJson(HiddenModel data) => json.encode(data.toJson());

class HiddenModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;

  HiddenModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
  });

  factory HiddenModel.fromJson(Map<String, dynamic> json) => HiddenModel(
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
  final bool unique;
  final bool required;

  Validations({
    required this.unique,
    required this.required,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        unique: json["unique"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "unique": unique,
        "required": required,
      };
}
