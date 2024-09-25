class FieldFormat {
  final String fieldFormat;
  final String inputGroupIcon;
  final String inputGroupIconPosition;

  FieldFormat({
    required this.fieldFormat,
    required this.inputGroupIcon,
    required this.inputGroupIconPosition,
  });

  factory FieldFormat.fromJson(Map<String, dynamic> json) => FieldFormat(
        fieldFormat: json["field_format"] ?? "default",
        inputGroupIcon: json["input_group_icon"] ?? "",
        inputGroupIconPosition: json["input_group_icon_position"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "field_format": fieldFormat,
        "input_group_icon": inputGroupIcon,
        "input_group_icon_position": inputGroupIconPosition,
      };
}
