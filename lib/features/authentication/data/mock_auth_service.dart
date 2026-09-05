import '../domain/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> resetPassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
