abstract class AuthService {
  Future<bool> login(String username, String password);
  Future<bool> register(String name, String email, String password);
  Future<bool> forgotPassword(String email);
  Future<bool> verifyOtp(String otp);
  Future<bool> resetPassword(String newPassword);
}
