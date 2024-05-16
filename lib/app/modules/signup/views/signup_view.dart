import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
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
                "Welcome,\nRegister here",
                style: Get.textTheme.displaySmall,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: controller.showError.value
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }

                  if (!GetUtils.isEmail(value)) {
                    return "Please enter a valid email";
                  }

                  return null;
                },
                onChanged: (value) {
                  controller.email.value = value;
                },
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Email',
                  hintText: "Enter your email",
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
                  autovalidateMode: controller.showError.value
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (value) {
                    if (value == null || !controller.validatedPassword(value)) {
                      return "Password must be at least 8 characters, 1 special character, 1 number, 1 upper and 1 lower";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.password.value = value;
                  },
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Password',
                    hintText: "Enter password",
                    helperMaxLines: 2,
                    helperText:
                        "Password must be at least 8 characters, 1 special character, 1 number, 1 upper and 1 lower",
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
                    onPressed: controller.isFormValid
                        ? controller.signUpClicked
                        : null,
                    icon: const Icon(Icons.login),
                    label: const Text('Register'));
              }),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}
