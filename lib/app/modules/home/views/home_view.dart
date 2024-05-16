import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome:\n${controller.user.email ?? ""}",
              style: Get.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.logOut();
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
