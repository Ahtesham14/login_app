import 'package:flutter/material.dart';
import 'package:flutter_task_app/services/form_services.dart';
import '../models/form_field_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormService _formService = FormService();
  List<FormFieldModel> _formFields = [];

  List<FormFieldModel> get formFields => _formFields;

  Future<void> fetchFormFields(String serviceName) async {
    _formFields = await _formService.fetchFormFields(serviceName);
    notifyListeners();
  }
}
