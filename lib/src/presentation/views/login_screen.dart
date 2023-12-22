import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../util/constants/constants.dart';
import '../../util/resources/strings.dart';
import '../../util/resources/dimens.dart';
import '../../config/router/routes_name.dart';
import '../../presentation/providers/login_provider.dart';
import '../../util/extensions/extensions.dart';
import '../../util/resources/colors.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgetPasswordEmailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: context.screenWidth / Dimensions.s16,
              right: context.screenWidth / Dimensions.s16,
              top: Dimensions.s30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    Constants.loginGIFAsset,
                    width: Dimensions.s200,
                    height: Dimensions.s200,
                  ),
                ),
                header(),
                CustomTextFormField(
                  controller: _emailController,
                  iconColor: ColorManager.greyColor,
                  hintText: StringManager.email,
                  borderColor: ColorManager.grey2Color,
                ),
                Dimensions.s10.marginHeight,
                passwordField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        StringManager.forgetPassword,
                        style: TextStyle(
                          fontSize: Dimensions.s12,
                          color: ColorManager.redColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        forgetPasswordDialog(context, provider);
                      },
                    ),
                  ],
                ),
                Selector<LoginProvider, bool>(
                  selector: (_, provider) => provider.isLoading,
                  builder: (_, isLoading, __) => CustomButton(
                    height: Dimensions.s52,
                    text: StringManager.signIn,
                    borderRadius: Dimensions.s10,
                    color: ColorManager.brownColor,
                    isLoading: isLoading,
                    circularProgressIndicatorSize: Dimensions.s30,
                    onPressed: () => provider.authUser(
                      _emailController.text,
                      _passwordController.text,
                      () {
                        // onAuthenticationSuccess
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.splashRoute,
                        );
                      },
                      (error) {
                        // onAuthenticationFail
                        error.showToast;
                      },
                    ),
                  ),
                ),
                context.screenHeight - Dimensions.s640 < Dimensions.s0
                    ? Dimensions.s60.marginHeight
                    : (context.screenHeight - Dimensions.s660).marginHeight,
                footer(context),
                Dimensions.s20.marginHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer<LoginProvider> passwordField() {
    return Consumer<LoginProvider>(
      builder: (_, provider, __) => CustomTextFormField(
        controller: _passwordController,
        hintText: StringManager.password,
        borderColor: ColorManager.grey2Color,
        isPasswordField: provider.isPasswordShown,
        suffixIcon: Icon(provider.isPasswordShown.passwordIcon),
        iconColor: ColorManager.greyColor,
        onSuffixIconTap: () => provider.togglePassword(),
      ),
    );
  }

  Future<Object?> forgetPasswordDialog(
    BuildContext context,
    LoginProvider provider,
  ) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) => Container(),
      transitionBuilder: (_, animation, __, ___) => ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            StringManager.forgetPasswordMessage,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 180,
            child: Column(children: [
              const Text(
                StringManager.enterEmail,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              CustomTextFormField(
                controller: _forgetPasswordEmailController,
                iconColor: ColorManager.greyColor,
                hintText: StringManager.yourEmail,
                borderColor: ColorManager.grey2Color,
              ),
              Dimensions.s16.marginHeight,
              Selector<LoginProvider, bool>(
                selector: (_, provider) => provider.isDialogLoading,
                builder: (_, isDialogLoading, __) => CustomButton(
                  height: Dimensions.s52,
                  text: StringManager.submit,
                  borderRadius: Dimensions.s10,
                  color: ColorManager.brownColor,
                  isLoading: isDialogLoading,
                  circularProgressIndicatorSize: Dimensions.s30,
                  onPressed: () => provider.resetPassword(
                      _forgetPasswordEmailController.text.trim(), (message) {
                    message.showToast;
                    _forgetPasswordEmailController.clear();
                    Navigator.of(context, rootNavigator: true).pop();
                  }, (error) {
                    error.showToast;
                  }),
                ),
              )
            ]),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.s16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dimensions.s20.marginHeight,
        Text(
          StringManager.signin,
          style: TextStyle(
            color: ColorManager.blackColor,
            fontSize: Dimensions.s34,
            fontFamily: Constants.notoSansLinearBFont,
            fontWeight: FontWeight.w100,
          ),
        ),
        Text(
          StringManager.accessAccount,
          style: TextStyle(
            color: ColorManager.lightGreyColor,
            fontSize: Dimensions.s16,
            fontFamily: Constants.notoSansLinearBFont,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Row footer(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringManager.createAccountMessage,
          style: TextStyle(color: ColorManager.greyColor),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, RoutesName.signupRoute),
          child: Text(
            StringManager.signUp,
            style: TextStyle(color: ColorManager.redColor),
          ),
        ),
      ],
    );
  }
}
