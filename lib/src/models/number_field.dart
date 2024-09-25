import 'package:zippy/src/models/field_format_model.dart';

class NumberFieldModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final FieldFormat fieldFormat;

  NumberFieldModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.fieldFormat,
  });

  factory NumberFieldModel.fromJson(Map<String, dynamic> json) =>
      NumberFieldModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        validations: Validations.fromJson(json["validations"]),
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
        "field_format": fieldFormat.toJson(),
      };
}

class Validations {
  final int max;
  final int min;
  final bool number;
  final bool decimal;
  final bool required;
  final int decimalPlaces;

  Validations({
    required this.max,
    required this.min,
    required this.number,
    required this.decimal,
    required this.required,
    required this.decimalPlaces,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        max: json["max"] ?? 99,
        min: json["min"] ?? 1,
        number: json["number"] ?? true,
        decimal: json["decimal"] ?? false,
        required: json["required"] ?? false,
        decimalPlaces: json["decimal_places"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
        "number": number,
        "decimal": decimal,
        "required": required,
        "decimal_places": decimalPlaces,
      };
}
