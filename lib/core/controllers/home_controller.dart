import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  final showFloatingMenu = false.obs;

  void changeIndex(int index) {
    _currentIndex.value = index;
  }

  void toggleFloatingMenu() {
    showFloatingMenu.value = !showFloatingMenu.value;
    update();
  }
}
