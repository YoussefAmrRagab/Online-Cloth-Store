abstract class AuthRepository {
  Future<String> registerUser(
    String name,
    String email,
    String password,
    String birthday,
    int weight,
    int height,
    String gender,
    String? imagePath,
  );

  Future<String> login(String email, String password);

  Future<String> sendResetPasswordEmail(String email);
}
