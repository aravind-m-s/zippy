// To parse this JSON data, do
//
//     final uploadModel = uploadModelFromJson(jsonString);

import 'dart:convert';

UploadModel uploadModelFromJson(String str) =>
    UploadModel.fromJson(json.decode(str));

String uploadModelToJson(UploadModel data) => json.encode(data.toJson());

class UploadModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final Validations validations;

  UploadModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.validations,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
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
  final bool file;
  final bool required;
  final int fileMaxSizeMb;
  final List<String> fileExtensionsAllowed;

  Validations({
    required this.file,
    required this.required,
    required this.fileMaxSizeMb,
    required this.fileExtensionsAllowed,
  });

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        file: json["file"],
        required: json["required"],
        fileMaxSizeMb: json["file_max_size_mb"],
        fileExtensionsAllowed:
            List<String>.from(json["file_extensions_allowed"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "required": required,
        "file_max_size_mb": fileMaxSizeMb,
        "file_extensions_allowed":
            List<dynamic>.from(fileExtensionsAllowed.map((x) => x)),
      };
}
