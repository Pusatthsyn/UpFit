import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Bottom bar aktif sekme indeksini yönetmek için
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
