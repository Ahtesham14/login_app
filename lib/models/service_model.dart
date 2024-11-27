// lib/models/servicelist_model.dart

class ServiceListModel {
  String? code;
  String? status;
  String? message;
  List<ServiceData>? data;

  ServiceListModel({this.code, this.status, this.message, this.data});

  factory ServiceListModel.fromJson(Map<String, dynamic> json) {
    return ServiceListModel(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => ServiceData.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceData {
  int? id;
  String? serviceName;
  String? image;
  List<FormFieldData>? formFields; // Added field to hold form fields

  ServiceData({this.id, this.serviceName, this.image, this.formFields});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['Id'],
      serviceName: json['ServiceName'],
      image: json['Image'],
      formFields: json['FormFields'] != null
          ? (json['FormFields'] as List)
              .map((item) => FormFieldData.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['ServiceName'] = this.serviceName;
    data['Image'] = this.image;
    if (this.formFields != null) {
      data['FormFields'] = this.formFields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormFieldData {
  final String fieldName;
  final String fieldType; // e.g., text, dropdown, date, checkbox
  final bool isRequired;
  final List<String>? options; // For dropdown fields
  final String? defaultValue;

  FormFieldData({
    required this.fieldName,
    required this.fieldType,
    this.isRequired = false,
    this.options,
    this.defaultValue,
  });

  factory FormFieldData.fromJson(Map<String, dynamic> json) {
    return FormFieldData(
      fieldName: json['FieldName'],
      fieldType: json['FieldType'],
      isRequired: json['IsRequired'] ?? false,
      options:
          json['Options'] != null ? List<String>.from(json['Options']) : null,
      defaultValue: json['DefaultValue'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['FieldName'] = this.fieldName;
    data['FieldType'] = this.fieldType;
    data['IsRequired'] = this.isRequired;
    if (this.options != null) {
      data['Options'] = this.options;
    }
    data['DefaultValue'] = this.defaultValue;
    return data;
  }
}
