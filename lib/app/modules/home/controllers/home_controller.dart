import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_signup_app/app/data/services/auth_services.dart';
import 'package:login_signup_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final AuthServices _authServices;

  StreamSubscription? _listenForAuthStateChange;
  late final User user;

  HomeController(this._authServices);
  @override
  void onInit() {
    user = _authServices.getCurrentUser();
    _listenForAuthStateChange =
        _authServices.listenForAuthStateChange.listen((event) {
      if (event == null) {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _listenForAuthStateChange?.cancel();
    super.onClose();
  }

  logOut() {
    _authServices.logOut();
  }
}
