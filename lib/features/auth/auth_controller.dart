import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:upfit/routes/app_routes.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Singleton
  late Rx<User?> _user; // Kullanıcı durumunu izlemek için reaktif yapı
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser); // Mevcut kullanıcıyı al
    _user.bindStream(auth.authStateChanges()); // Kullanıcı durumunu dinle
    ever(_user,
        _setInitialScreen); // Kullanıcı durumuna göre ekran yönlendirmesi
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(
          AppRoutes.login); // Kullanıcı yoksa Login ekranına yönlendir
    } else {
      Get.offAllNamed(
          AppRoutes.dashboard); // Kullanıcı varsa Dashboard ekranına yönlendir
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
