import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  void login() {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Hata!',
        'Lütfen Tüm Alanları Doldurun!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Firebase Authentication login logic
    // Navigate to HomePage on successful login
    Get.offNamed('/home');
  }
}
