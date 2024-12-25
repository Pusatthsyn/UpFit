import 'package:get/get.dart';
import 'package:upfit/features/signUp/signUp_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
