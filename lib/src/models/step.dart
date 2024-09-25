class StepModel {
  final String id;
  final String name;
  bool isCurrentStep;

  StepModel({
    this.id = "",
    this.name = "",
    this.isCurrentStep = true,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        id: json["id"],
        name: json["name"],
        isCurrentStep: json["is_current_step"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_current_step": isCurrentStep,
      };

  @override
  toString() {
    return "[Step] - Id: $id, Name: $name, Is Current Step: $isCurrentStep";
  }
}
