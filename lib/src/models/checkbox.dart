// To parse this JSON data, do
//
//     final checkboxModel = checkboxModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckboxModel checkboxModelFromJson(String str) =>
    CheckboxModel.fromJson(json.decode(str));

String checkboxModelToJson(CheckboxModel data) => json.encode(data.toJson());

class CheckboxModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final List<Option> options;

  CheckboxModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.options,
  });

  factory CheckboxModel.fromJson(Map<String, dynamic> json) => CheckboxModel(
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
  final bool required;
  final int maxSelection;

  Validations({
    required this.required,
    required this.maxSelection,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        required: json["required"],
        maxSelection: json["max_selection"],
      );

  Map<String, dynamic> toJson() => {
        "required": required,
        "max_selection": maxSelection,
      };
}
