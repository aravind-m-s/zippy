import 'package:zippy/src/models/field_format_model.dart';

class EmailModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final FieldFormat fieldFormat;

  EmailModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.fieldFormat,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) => EmailModel(
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
  final bool email;
  final bool unique;
  final bool required;

  Validations({
    required this.email,
    required this.unique,
    required this.required,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        email: json["email"],
        unique: json["unique"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "unique": unique,
        "required": required,
      };
}
