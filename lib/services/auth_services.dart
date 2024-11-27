import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    const mockUsername = "test@example.com";
    const mockPassword = "password123";

    if (username == mockUsername && password == mockPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      return true;
    }
    return false;
  }
}
