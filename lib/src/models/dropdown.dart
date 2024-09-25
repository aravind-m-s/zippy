// To parse this JSON data, do
//
//     final dropdownModel = dropdownModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DropdownModel dropdownModelFromJson(String str) =>
    DropdownModel.fromJson(json.decode(str));

String dropdownModelToJson(DropdownModel data) => json.encode(data.toJson());

class DropdownModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final List<DropdownOption> options;
  final FieldFormat fieldFormat;

  DropdownModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.options,
    required this.fieldFormat,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        validations: Validations.fromJson(json["validations"]),
        options: List<DropdownOption>.from(
            json["options"].map((x) => DropdownOption.fromJson(x))),
        fieldFormat: FieldFormat.fromJson(json["field_format"]),
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
        "field_format": fieldFormat.toJson(),
      };
}

class FieldFormat {
  final String fieldFormat;

  FieldFormat({
    required this.fieldFormat,
  });

  factory FieldFormat.fromJson(Map<String, dynamic> json) => FieldFormat(
        fieldFormat: json["field_format"],
      );

  Map<String, dynamic> toJson() => {
        "field_format": fieldFormat,
      };
}

class DropdownOption {
  final String value;
  final String label;

  DropdownOption({
    required this.value,
    required this.label,
  });

  factory DropdownOption.fromJson(Map<String, dynamic> json) => DropdownOption(
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
