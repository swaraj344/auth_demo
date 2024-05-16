import 'package:get/get.dart';
import 'package:login_signup_app/app/data/services/auth_services.dart';
import 'package:login_signup_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthServices _authServices;

  SplashController(this._authServices);
  @override
  void onInit() {
    Future.delayed(2.seconds, () {
      if (_authServices.isLoggedIn) {
        Get.offAllNamed(Routes.HOME);
      } else {
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
    super.onClose();
  }
}
