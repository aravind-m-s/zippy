// To parse this JSON data, do
//
//     final advancedDropdownModel = advancedDropdownModelFromJson(jsonString);

import 'dart:convert';

AdvancedDropdownModel advancedDropdownModelFromJson(String str) =>
    AdvancedDropdownModel.fromJson(json.decode(str));

String advancedDropdownModelToJson(AdvancedDropdownModel data) =>
    json.encode(data.toJson());

class AdvancedDropdownModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final String optionApiUrl;

  AdvancedDropdownModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.optionApiUrl,
  });

  factory AdvancedDropdownModel.fromJson(Map<String, dynamic> json) =>
      AdvancedDropdownModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        validations: Validations.fromJson(json["validations"]),
        optionApiUrl: json["option_api_url"],
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "field_type": fieldType,
        "field_order": fieldOrder,
        "class_name": className,
        "label": label,
        "placeholder": placeholder,
        "validations": validations.toJson(),
        "option_api_url": optionApiUrl,
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

class AdvancedDropdownItemModel {
  final String id;
  final String label;

  AdvancedDropdownItemModel({
    required this.id,
    required this.label,
  });

  factory AdvancedDropdownItemModel.fromJson(Map<String, dynamic> json) =>
      AdvancedDropdownItemModel(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}
