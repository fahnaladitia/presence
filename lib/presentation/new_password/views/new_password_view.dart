import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Password'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Obx(
              () => TextField(
                obscureText: controller.isObscure.value,
                controller: controller.newPasswordC,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'New Password',
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
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  await controller.newPassword();
                },
                child: Text('CONTINUE'))
          ],
        ));
  }
}
