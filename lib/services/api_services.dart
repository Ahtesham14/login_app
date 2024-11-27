import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fetch services from the API
  Future<List<Service>> fetchServices() async {
    try {
      // Send GET request to the API
      final response = await _dio.get(
          'http://citizenservice.vupadhi.com/api/webapi/serviceslist?Name=Welfare Scheme');

      // Check if the response is valid and contains the expected data
      if (response.statusCode == 200) {
        // Assuming the response has a 'data' field containing the list of services
        final serviceList = response.data['data']; // Get the 'data' field

        // Map the list of services to Service objects
        return (serviceList as List)
            .map((json) => Service.fromJson(json))
            .toList();
      } else {
        // Handle other response status codes
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions with more details
      print('Error fetching services: $e');
      throw Exception('Failed to load services: $e');
    }
  }
}

class Service {
  final String serviceName;
  final String? imageUrl;

  Service({required this.serviceName, this.imageUrl});

  // Factory method to create a Service from JSON
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName:
          json['ServiceName'] ?? 'No Service Name', // Ensure it's never null
      imageUrl: _getFullImageUrl(json['Image']), // Handle the image URL safely
    );
  }

  // Helper function to form full image URL if the API returns a relative path
  static String? _getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return null;
    }
    // Prepend the base URL if it's a relative path
    const baseUrl = 'http://citizenservice.vupadhi.com';
    return imageUrl.startsWith('http') ? imageUrl : baseUrl + imageUrl;
  }
}
