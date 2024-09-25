class TextAreaModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String label;
  final String placeholder;
  final int lines;
  final Validations validations;

  TextAreaModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.label,
    required this.placeholder,
    required this.lines,
    required this.validations,
  });

  factory TextAreaModel.fromJson(Map<String, dynamic> json) => TextAreaModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        label: json["label"],
        placeholder: json["placeholder"],
        lines: json["field_type"] == "short_text_area" ? 3 : 6,
        validations: Validations.fromJson(json["validations"]),
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "field_type": fieldType,
        "field_order": fieldOrder,
        "class_name": className,
        "label": label,
        "placeholder": placeholder,
        "lines": lines,
        "validations": validations.toJson(),
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
        required: json["required"],
        maxlength: json["maxlength"],
        minlength: json["minlength"],
      );

  Map<String, dynamic> toJson() => {
        "required": required,
        "maxlength": maxlength,
        "minlength": minlength,
      };
}
