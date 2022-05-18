import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(
                Routes.ADD_PEGAWAI,
              ),
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Obx(() {
            if (controller.isLoading.isFalse) {
              return Text(
                'HomeView is working',
                style: TextStyle(fontSize: 20),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
        floatingActionButton: Obx(() => FloatingActionButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.logout();
                }
              },
              backgroundColor:
                  controller.isLoading.isFalse ? Colors.blue : Colors.grey,
              child: Icon(Icons.logout),
            )));
  }
}
