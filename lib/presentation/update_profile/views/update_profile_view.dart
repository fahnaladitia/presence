import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/pegawai.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  Pegawai pegawai = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = pegawai.nip.toString();
    controller.nameC.text = pegawai.name;
    controller.emailC.text = pegawai.email;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              readOnly: true,
              autocorrect: false,
              controller: controller.nipC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'NIP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              readOnly: true,
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: controller.nameC,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      controller.updateProfile();
                    }
                  },
                  child: controller.isLoading.isFalse
                      ? Text('Update Profile')
                      : Text('Loading...'),
                )),
          ],
        ));
  }
}
