import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UpdatePasswordView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Obx(() => TextField(
                  autocorrect: false,
                  obscureText: controller.isObscureCurr.value,
                  controller: controller.currC,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(controller.isObscureCurr.isFalse
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.isObscureCurr.value =
                            !controller.isObscureCurr.value;
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Current Password',
                  ),
                )),
            SizedBox(height: 20),
            Obx(() => TextField(
                  autocorrect: false,
                  obscureText: controller.isObscureNew.value,
                  controller: controller.newC,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(controller.isObscureNew.isFalse
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.isObscureNew.value =
                            !controller.isObscureNew.value;
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'New Password',
                  ),
                )),
            SizedBox(height: 20),
            Obx(() => TextField(
                  autocorrect: false,
                  obscureText: controller.isObscureConfirm.value,
                  controller: controller.confirmC,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(controller.isObscureConfirm.isFalse
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.isObscureConfirm.value =
                            !controller.isObscureConfirm.value;
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm New Password',
                  ),
                )),
            SizedBox(height: 10),
            Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.updatePassword();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? 'Change Password'
                    : 'Loading...')))
          ],
        ));
  }
}
