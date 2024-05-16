import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_app/app/data/services/auth_services.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthServices _authServices;

  LoginController(this._authServices);

  StreamSubscription? _listenForAuthStateChange;
  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final showPassword = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _listenForAuthStateChange =
        _authServices.listenForAuthStateChange.listen((event) {
      if (event != null) {
        Get.offAllNamed(Routes.HOME);
      }
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> loginClicked() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await _authServices.login(email.value, password.value).then((value) {
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

  @override
  void onClose() {
    _listenForAuthStateChange?.cancel();
    super.onClose();
  }

  bool get isFormValid {
    return GetUtils.isEmail(email.value) && password.value.length >= 8;
  }

  loginWithGoogleClicked() async {
    isLoading.value = true;

    await _authServices.loginWithGoogle().then((value) {
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
    isLoading.value = false;
  }
}
