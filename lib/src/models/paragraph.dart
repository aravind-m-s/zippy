class ParagraphModel {
  final String fieldId;
  final String fieldType;
  final int fieldOrder;
  final String className;
  final String content;
  final String contentSize;
  final String contentAlignment;

  ParagraphModel({
    required this.fieldId,
    required this.fieldType,
    required this.fieldOrder,
    required this.className,
    required this.content,
    required this.contentSize,
    required this.contentAlignment,
  });

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => ParagraphModel(
        fieldId: json["field_id"],
        fieldType: json["field_type"],
        fieldOrder: json["field_order"],
        className: json["class_name"],
        content: json["content"],
        contentSize: json["content_size"],
        contentAlignment: json["content_alignment"],
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "field_type": fieldType,
        "field_order": fieldOrder,
        "class_name": className,
        "content": content,
        "content_size": contentSize,
        "content_alignment": contentAlignment,
      };
}
