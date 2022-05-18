import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => TextField(
                autocorrect: false,
                controller: controller.passwordC,
                obscureText: controller.isObscure.value,
                // keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.isObscure.value =
                            !controller.isObscure.value;
                      },
                      icon: Icon(controller.isObscure.value
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.loginStream();
                  }
                },
                child:
                    Text(controller.isLoading.isFalse ? 'LOGIN' : 'LOADING...'),
              ),
            ),
            TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: Text('Lupa password ?'))
          ],
        ));
  }
}
