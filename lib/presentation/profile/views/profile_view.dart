import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';

import '../../../app/routes/app_pages.dart';
import '../../../domain/entities/pegawai.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();
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
                String defaultImage =
                    'https://ui-avatars.com/api/?name=${snapshot.data!.name}';
                print(snapshot.data);
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
                              snapshot.data!.profile != null
                                  ? snapshot.data!.profile != ''
                                      ? snapshot.data!.profile!
                                      : defaultImage
                                  : defaultImage,
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Absen'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
