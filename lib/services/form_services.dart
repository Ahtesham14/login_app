import '../models/form_field_model.dart';

class FormService {
  Future<List<FormFieldModel>> fetchFormFields(String serviceName) async {
    // Simulate dynamic form field fetching for demo purposes
    return [
      FormFieldModel(
          label: "Enter Aadhar Number", type: "text", required: true),
      FormFieldModel(label: "Enter Name", type: "text", required: true),
      FormFieldModel(label: "Select Gender", type: "dropdown", required: true),
    ];
  }
}
