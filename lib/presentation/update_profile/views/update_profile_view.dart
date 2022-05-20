import 'dart:io';

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
    controller.imageUrl.value = pegawai.profile ?? '';
    final defaultImageUrl = 'https://ui-avatars.com/api/?name=${pegawai.name}';
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
            SizedBox(height: 20),
            Text(
              'Photo Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: controller.image.value != null
                                  ? Image.file(
                                      File(controller.image.value!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      controller.imageUrl.value != ''
                                          ? controller.imageUrl.value
                                          : defaultImageUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          if (controller.imageUrl.value != '')
                            TextButton(
                                onPressed: () {
                                  if (controller.isLoading.isFalse) {
                                    controller.deleteImageProfile();
                                  }
                                },
                                child: Text('delete'))
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.pickImage();
                            }
                          },
                          child: Text(controller.isLoading.isFalse
                              ? 'choose file'
                              : '')),
                    ])),
            SizedBox(height: 30),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    controller.updateProfile();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? 'Update Profile'
                    : 'Loading...'))),
          ],
        ));
  }
}
