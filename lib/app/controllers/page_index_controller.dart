import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/services/geolocator_service.dart';

class PageIndexController extends GetxController {
  final GeolocatorService _geolocatorService;

  PageIndexController(this._geolocatorService);
  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    switch (i) {
      case 1:
        print('absen');
        final result = await _geolocatorService.determinePosition();
        if (!result['error']) {
          Position position = result['position'];

          Get.snackbar("${result['message']}",
              '${position.latitude} - ${position.longitude}');
        } else {
          Get.snackbar('Terjadi Kesalahan', result['message']);
        }
        print('Selesai');
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
