class FormFieldModel {
  final String label;
  final String type;
  final bool required;

  FormFieldModel(
      {required this.label, required this.type, this.required = false});

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      label: json['label'],
      type: json['type'],
      required: json['required'] ?? false,
    );
  }
}
