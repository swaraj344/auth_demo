import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_services.dart';

class SignupController extends GetxController {
  final AuthServices _authServices;

  SignupController(this._authServices);

  final email = "".obs;
  final password = "".obs;
  final showPassword = false.obs;
  final isLoading = false.obs;
  final showError = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  signUpClicked() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await _authServices.signup(email.value, password.value).then((value) {
        value.leftMap((l) {
          l.maybeWhen(
            serverError: (message) {
              Get.snackbar(
                "Server error",
                message ?? "",
                snackPosition: SnackPosition.BOTTOM,
                duration: 5.seconds,
              );
            },
            orElse: () {
              Get.snackbar(
                "Error",
                "Unexpected error. Please try again",
                snackPosition: SnackPosition.BOTTOM,
                duration: 5.seconds,
              );
            },
          );
        });
      });
      isLoading.value = true;
    }
  }

  bool validatedPassword(String value) {
    // min 8 characters, 1 special character, 1 number, 1 upper and 1 lower
    RegExp regex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$');

    return regex.hasMatch(value);
  }

  bool get isFormValid {
    return GetUtils.isEmail(email.value) && validatedPassword(password.value);
  }
}
