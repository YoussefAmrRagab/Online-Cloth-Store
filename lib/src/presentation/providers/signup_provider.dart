import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../util/resources/strings.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../util/extensions/extensions.dart';

class SignupProvider extends ChangeNotifier {
  late final AuthRepository _authRepository;

  SignupProvider(this._authRepository);

  final List<String> _options = [StringManager.male, StringManager.female];

  String get maleOption => _options[0];

  String get femaleOption => _options[1];

  late bool _isPasswordHidden = true;

  bool get isPasswordHidden => _isPasswordHidden;

  void togglePassword() {
    _isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  late bool _isConfirmPasswordHidden = true;

  bool get isConfirmPasswordHidden => _isConfirmPasswordHidden;

  void toggleConfirmPassword() {
    _isConfirmPasswordHidden = !isConfirmPasswordHidden;
    notifyListeners();
  }

  late String _currentOption = maleOption;

  String get currentOption => _currentOption;

  set currentOption(String selectedOption) {
    _currentOption = selectedOption;
    notifyListeners();
  }

  String _birthdate = "";

  String get birthdate => _birthdate;

  set birthdate(String date) {
    _birthdate = date;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void toggleLoading() {
    _isLoading = !isLoading;
    notifyListeners();
  }

  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  set selectImage(XFile? pickedImage) {
    _selectedImage = pickedImage;
    notifyListeners();
  }

  void registerUser(
      String name,
      String email,
      String password,
      String confirmPassword,
      String birthday,
      String weight,
      String height,
      Function() onSuccess,
      Function(String error) onFail) async {
    toggleLoading();
    String? validatingResponse = isValid(
      name,
      email,
      password,
      confirmPassword,
      birthday,
      weight,
      height,
    );

    if (validatingResponse != null) {
      onFail(validatingResponse);
      toggleLoading();
      return;
    }

    if (!email.isValidEmail) {
      onFail(StringManager.invalidEmailFormat);
      toggleLoading();
      return;
    } else if (!password.isValidPassword) {
      onFail(StringManager.weakPassword);
      toggleLoading();
      return;
    }

    String res = await _authRepository.registerUser(
      name,
      email,
      password,
      birthday,
      int.parse(weight),
      int.parse(height),
      _currentOption,
      selectedImage?.path,
    );

    if (res == StringManager.success) {
      onSuccess();
    } else {
      onFail(res);
    }
    toggleLoading();
  }

  String? isValid(
    String name,
    String email,
    String password,
    String confirmPassword,
    String birthday,
    String weight,
    String height,
  ) {
    if (name.isEmpty) {
      return StringManager.nameFieldEmpty;
    } else if (email.isEmpty) {
      return StringManager.emailFieldEmpty;
    } else if (password.isEmpty) {
      return StringManager.passwordFieldEmpty;
    } else if (confirmPassword.isEmpty) {
      return StringManager.confirmPasswordFieldEmpty;
    } else if (password != confirmPassword) {
      return StringManager.notMatchedPasswords;
    } else if (birthday.isEmpty) {
      return StringManager.birthdayFieldEmpty;
    } else if (weight.isEmpty) {
      return StringManager.weightFieldEmpty;
    } else if (height.isEmpty) {
      return StringManager.heightFieldEmpty;
    }
    return null;
  }
}
