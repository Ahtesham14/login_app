import 'package:flutter/material.dart';
import 'package:flutter_task_app/services/api_services.dart';
import '../models/service_model.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Service> _services = [];

  List<Service> get services => _services;

  Future<void> fetchServices() async {
    _services = await _apiService.fetchServices();
    notifyListeners();
  }
}
