import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_radio.dart';
import '../widgets/custom_button.dart';
import '../../config/router/routes_name.dart';
import '../../presentation/providers/signup_provider.dart';
import '../../util/resources/colors.dart';
import '../../presentation/widgets/custom_text_form_field.dart';
import '../../util/extensions/extensions.dart';
import '../../util/constants/constants.dart';
import '../../util/resources/strings.dart';
import '../../util/resources/dimens.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context, listen: false);

    return Scaffold(
      body: PopScope(
        onPopInvoked: (_) => clear(provider),
        child: SafeArea(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      header(),
                      imagePicker(provider),
                    ],
                  ),
                  Dimensions.s16.marginHeight,
                  CustomTextFormField(
                    controller: _usernameController,
                    iconColor: ColorManager.greyColor,
                    hintText: StringManager.name,
                    borderColor: ColorManager.grey2Color,
                  ),
                  Dimensions.s10.marginHeight,
                  CustomTextFormField(
                    controller: _emailController,
                    iconColor: ColorManager.greyColor,
                    hintText: StringManager.email,
                    borderColor: ColorManager.grey2Color,
                  ),
                  Dimensions.s10.marginHeight,
                  passwordField(provider),
                  Dimensions.s10.marginHeight,
                  confirmPasswordField(provider),
                  datePickerField(context),
                  weightAndHeightFields(context),
                  Dimensions.s10.marginHeight,
                  radioGroup(provider),
                  Dimensions.s20.marginHeight,
                  signUpButton(provider, context),
                  Dimensions.s10.marginHeight
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row weightAndHeightFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextFormField(
          width: context.screenWidth / Dimensions.s2_4,
          controller: _weightController,
          iconColor: ColorManager.greyColor,
          hintText: StringManager.weight,
          borderColor: ColorManager.grey2Color,
          isNumericKeyboardType: true,
          enableInteractiveSelection: false,
        ),
        CustomTextFormField(
          width: context.screenWidth / Dimensions.s2_4,
          controller: _heightController,
          iconColor: ColorManager.greyColor,
          hintText: StringManager.height,
          borderColor: ColorManager.grey2Color,
          isNumericKeyboardType: true,
          enableInteractiveSelection: false,
        )
      ],
    );
  }

  Selector<SignupProvider, bool> signUpButton(
    SignupProvider provider,
    BuildContext context,
  ) {
    return Selector<SignupProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (_, isLoading, __) => CustomButton(
        isLoading: isLoading,
        height: Dimensions.s52,
        text: StringManager.signUp,
        borderRadius: Dimensions.s10,
        color: ColorManager.brownColor,
        circularProgressIndicatorSize: Dimensions.s30,
        onPressed: () => provider.registerUser(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
          _birthdayController.text,
          _weightController.text,
          _heightController.text,
          () {
            // onRegistrationSuccess
            StringManager.verifyEmail.showToast;
            clear(provider);
            Navigator.pushReplacementNamed(
              context,
              RoutesName.loginRoute,
            );
          },
          (error) {
            // onRegistrationFail
            error.showToast;
          },
        ),
      ),
    );
  }

  Consumer<SignupProvider> datePickerField(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (_, __, ___) => CustomTextFormField(
        isDatePickerField: true,
        iconColor: ColorManager.greyColor,
        hintText: StringManager.birthday,
        borderColor: ColorManager.grey2Color,
        controller: _birthdayController,
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(Constants.firstDate),
            lastDate: DateTime(Constants.lastDate),
          );
          if (date != null) {
            _birthdayController.text = "${date.day}-${date.month}-${date.year}";
          }
        },
      ),
    );
  }

  Selector<SignupProvider, bool> passwordField(SignupProvider provider) {
    return Selector<SignupProvider, bool>(
      selector: (_, provider) => provider.isPasswordHidden,
      builder: (_, isPasswordHidden, __) => CustomTextFormField(
        controller: _passwordController,
        iconColor: ColorManager.greyColor,
        hintText: StringManager.password,
        borderColor: ColorManager.grey2Color,
        onSuffixIconTap: () => provider.togglePassword(),
        isPasswordField: isPasswordHidden,
        suffixIcon: Icon(isPasswordHidden.passwordIcon),
      ),
    );
  }

  Selector<SignupProvider, bool> confirmPasswordField(SignupProvider provider) {
    return Selector<SignupProvider, bool>(
      selector: (_, provider) => provider.isConfirmPasswordHidden,
      builder: (_, isConfirmPasswordHidden, __) => CustomTextFormField(
        controller: _confirmPasswordController,
        iconColor: ColorManager.greyColor,
        hintText: StringManager.confirmPassword,
        borderColor: ColorManager.grey2Color,
        onSuffixIconTap: () => provider.toggleConfirmPassword(),
        isPasswordField: isConfirmPasswordHidden,
        suffixIcon: Icon(isConfirmPasswordHidden.passwordIcon),
      ),
    );
  }

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.signup,
          style: TextStyle(
            color: ColorManager.blackColor,
            fontSize: Dimensions.s34,
            fontFamily: Constants.notoSansLinearBFont,
            fontWeight: FontWeight.w100,
          ),
        ),
        Text(
          StringManager.createAccount,
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

  InkWell imagePicker(SignupProvider provider) {
    return InkWell(
      onTap: () async {
        provider.selectImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      },
      overlayColor: MaterialStatePropertyAll(ColorManager.whiteColor),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Selector<SignupProvider, XFile?>(
            selector: (_, provider) => provider.selectedImage,
            builder: (_, userImage, __) => ClipOval(
              child: CircleAvatar(
                radius: Dimensions.s40,
                backgroundColor: ColorManager.brownColor,
                child: userImage == null
                    ? Padding(
                        padding: const EdgeInsets.all(Dimensions.s16),
                        child: Image.asset(
                          Constants.userAsset,
                          color: ColorManager.whiteColor,
                        ),
                      )
                    : Image.file(
                        File(userImage.path),
                        fit: BoxFit.cover,
                        width: Dimensions.s80,
                        height: Dimensions.s80,
                      ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                right: Dimensions.s6, bottom: Dimensions.s2),
            decoration: BoxDecoration(
              color: ColorManager.blueColor,
              borderRadius: BorderRadius.circular(Dimensions.s100),
            ),
            child: Icon(
              size: Dimensions.s24,
              Icons.add_rounded,
              color: ColorManager.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Column radioGroup(SignupProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.gender,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorManager.grey2Color,
            fontSize: Dimensions.s16,
          ),
        ),
        Dimensions.s6.marginHeight,
        Selector<SignupProvider, String>(
          selector: (_, provider) => provider.currentOption,
          builder: (_, currentOption, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRadio(
                  text: StringManager.male,
                  value: provider.maleOption,
                  groupValue: currentOption,
                  onChanged: (value) {
                    provider.currentOption = value.toString();
                  },
                ),
                Dimensions.s5.marginWidth,
                CustomRadio(
                  text: StringManager.female,
                  value: provider.femaleOption,
                  groupValue: currentOption,
                  onChanged: (value) {
                    provider.currentOption = value.toString();
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void clear(SignupProvider provider) {
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _birthdayController.clear();
    _weightController.clear();
    _heightController.clear();
    provider.selectImage = null;
    provider.currentOption = provider.maleOption;
  }
}
