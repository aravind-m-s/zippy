import 'package:zippy/src/models/field_format_model.dart';

class WebsiteModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;
  final FieldFormat fieldFormat;

  WebsiteModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
    required this.fieldFormat,
  });

  factory WebsiteModel.fromJson(Map<String, dynamic> json) => WebsiteModel(
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
  final bool url;
  final bool unique;
  final bool required;

  Validations({
    required this.url,
    required this.unique,
    required this.required,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        url: json["url"],
        unique: json["unique"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "unique": unique,
        "required": required,
      };
}
