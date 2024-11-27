import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoggingIn = false; // Private field for tracking login state
  String? _errorMessage; // Holds any error message

  bool get isLoggingIn => _isLoggingIn; // Getter for isLoggingIn
  String? get errorMessage => _errorMessage; // Getter for errorMessage

  Future<bool> login(String username, String password) async {
    _isLoggingIn = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simulate a network call

    // Mock credentials
    const mockUsername = "test@example.com";
    const mockPassword = "password123";

    if (username == mockUsername && password == mockPassword) {
      _isLoggingIn = false;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('isLoggedIn', true);
      notifyListeners();
      return true;
    } else {
      _isLoggingIn = false;
      _errorMessage = "Invalid credentials";
      notifyListeners();
      return false;
    }
  }

  // Future<void> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _isLoggingIn =
  //       prefs.getBool('isLoggedIn') ?? false; // Default to false if not set
  //   notifyListeners();
  // }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);

    _isLoggingIn = false;
    notifyListeners();
  }
}
