// To parse this JSON data, do
//
//     final radioModel = radioModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RadioModel radioModelFromJson(String str) =>
    RadioModel.fromJson(json.decode(str));

String radioModelToJson(RadioModel data) => json.encode(data.toJson());

class RadioModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final List<Option> options;

  RadioModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.options,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) => RadioModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        validations: Validations.fromJson(json["validations"]),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "field_type": fieldType,
        "field_order": fieldOrder,
        "class_name": className,
        "label": label,
        "placeholder": placeholder,
        "validations": validations.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  final String value;
  final String label;

  Option({
    required this.value,
    required this.label,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
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
