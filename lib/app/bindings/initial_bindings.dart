import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup_app/app/data/services/auth_services.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuth>(FirebaseAuth.instance);
    Get.put<GoogleSignIn>(GoogleSignIn());
    Get.lazyPut<AuthServices>(() => AuthServices(Get.find(), Get.find()));
  }
}
