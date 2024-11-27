import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_app/models/service_model.dart';

class ServiceListViewModel extends ChangeNotifier {
  bool _isLoading = true;
  List<ServiceData> _services = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ServiceData> get services => _services;
  String? get errorMessage => _errorMessage;

  ServiceListViewModel() {
    fetchServices();
  }

  Future<void> fetchServices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final dio = Dio();
    final url =
        "http://citizenservice.vupadhi.com/api/webapi/serviceslist?Name=Welfare Scheme";

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final serviceList = ServiceListModel.fromJson(response.data);

        // Update the services list
        _services = serviceList.data ?? [];
      } else {
        _errorMessage = "Failed to load services.";
      }
    } catch (error) {
      _errorMessage = "Failed to load services: $error";
    }

    _isLoading = false;
    notifyListeners();
  }
}
