import 'package:flutter/material.dart';
import '../../util/resources/strings.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginProvider extends ChangeNotifier {
  late final AuthRepository _authRepository;

  LoginProvider(this._authRepository);

  bool isPasswordShown = false;

  void togglePassword() {
    isPasswordShown = !isPasswordShown;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void toggleLoading() {
    _isLoading = !isLoading;
    notifyListeners();
  }

  bool _isDialogLoading = false;

  bool get isDialogLoading => _isDialogLoading;

  void toggleLoadingDialog() {
    _isDialogLoading = !isDialogLoading;
    notifyListeners();
  }

  void authUser(
    String email,
    String password,
    Function() onSuccess,
    Function(String error) onFail,
  ) async {
    toggleLoading();
    if (email.isEmpty) {
      onFail(StringManager.emailFieldEmpty);
      toggleLoading();
      return;
    } else if (password.isEmpty) {
      onFail(StringManager.passwordFieldEmpty);
      toggleLoading();
      return;
    }
    String res = await _authRepository.login(email, password);

    if (res != StringManager.success) {
      onFail(res);
    } else {
      onSuccess();
    }
    toggleLoading();
  }

  void resetPassword(
    String email,
    Function(String message) onSuccess,
    Function(String error) onFail,
  ) async {
    toggleLoadingDialog();
    String res = await _authRepository.sendResetPasswordEmail(email);
    if (res == StringManager.resetPasswordMessage) {
      onSuccess(res);
    } else {
      onFail(res);
    }
    toggleLoadingDialog();
  }
}
