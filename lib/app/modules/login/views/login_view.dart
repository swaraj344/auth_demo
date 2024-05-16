import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:login_signup_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            shrinkWrap: true,
            children: [
              Text(
                "Welcome Back!\nLogin here",
                style: Get.textTheme.displaySmall,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  controller.email.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }

                  if (!GetUtils.isEmail(value)) {
                    return "Please enter a valid email";
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Email',
                  hintText: "Enter your email",
                  suffixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(() {
                return TextFormField(
                  onChanged: (value) {
                    controller.password.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Password',
                    hintText: "Enter password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.showPassword.value =
                              !controller.showPassword.value;
                        },
                        icon: Icon(controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return OutlinedButton.icon(
                    onPressed:
                        controller.isFormValid ? controller.loginClicked : null,
                    icon: const Icon(Icons.login),
                    label: const Text('Login'));
              }),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: const Text("Don't have an account? Sign Up")),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                      child: Divider(
                    indent: 10,
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      foregroundColor: Get.theme.colorScheme.onPrimary,
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.loginWithGoogleClicked();
                          },
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 30,
                    ),
                    label: const Text("Login With Google"));
              })
            ],
          ),
        ),
      ),
    );
  }
}
