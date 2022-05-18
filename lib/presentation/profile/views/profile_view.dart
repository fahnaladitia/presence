import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../domain/entities/pegawai.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<Pegawai>(
          stream: controller.currentPegawai(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              'https://ui-avatars.com/api/?name=${snapshot.data!.name}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      snapshot.data!.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Update Profile'),
                      onTap: () => Get.toNamed(
                        Routes.UPDATE_PROFILE,
                        arguments: snapshot.data,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.vpn_key),
                      title: Text('Update Password'),
                      onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                    ),
                    if (snapshot.data!.role == 'admin')
                      ListTile(
                        leading: Icon(Icons.person_add),
                        title: Text('Add Pegawai'),
                        onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                      ),
                    Obx(() => ListTile(
                          leading: controller.isLoading.isFalse
                              ? Icon(Icons.logout)
                              : CircularProgressIndicator(),
                          title: Text('Logout'),
                          onTap: () {
                            if (controller.isLoading.isFalse) {
                              controller.logout();
                            }
                          },
                        )),
                  ],
                );
              } else {
                return Center(
                  child: Text('Tidak dapat memuat data user.'),
                );
              }
            }
          }),
    );
  }
}
