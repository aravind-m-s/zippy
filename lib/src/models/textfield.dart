import 'package:zippy/src/models/field_format_model.dart';

class TextFieldModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final FieldFormat fieldFormat;

  TextFieldModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.fieldFormat,
  });

  factory TextFieldModel.fromJson(Map<String, dynamic> json) => TextFieldModel(
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
  final bool required;
  final int maxlength;
  final int minlength;

  Validations({
    required this.required,
    required this.maxlength,
    required this.minlength,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        required: json["required"] ?? false,
        maxlength: json["maxlength"] ?? 256,
        minlength: json["minlength"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "required": required,
        "maxlength": maxlength,
        "minlength": minlength,
      };
}
