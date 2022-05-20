import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import '../../../app/controllers/page_index_controller.dart';
import '../../../domain/entities/pegawai.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: StreamBuilder<Pegawai>(
          stream: controller.currentPegawai(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 75,
                            width: 75,
                            color: Colors.grey.shade200,
                            child: Image.network(
                              snapshot.data!.profile != null &&
                                      snapshot.data!.profile != ''
                                  ? snapshot.data!.profile!
                                  : 'https://ui-avatars.com/api/?name=${snapshot.data!.name}',
                              fit: BoxFit.cover,
                            ),
                            // child: Image.,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Belum ada lokasi',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.job,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            snapshot.data!.nip.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Masuk'),
                                Text('-'),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                Text('Keluar'),
                                Text('-'),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 20),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Last 5 days',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                            onPressed: () => Get.toNamed(Routes.ALL_PRESENSI),
                            child: Text(
                              'See more',
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Material(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(Routes.DETAIL_PRESENSI),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Masuk',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${DateFormat.yMMMEd().format(DateTime.now())}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          '${DateFormat.jms().format(DateTime.now())}'),
                                      SizedBox(height: 10),
                                      Text(
                                        'Keluar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          '${DateFormat.jms().format(DateTime.now())}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                );
              } else {
                return Center(
                  child: Text('Tidak dapat memuat database user.'),
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
