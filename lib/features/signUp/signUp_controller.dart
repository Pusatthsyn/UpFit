import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Create user with email and password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Store additional user data in Firestore
      await _createUserProfile(userCredential.user!.uid);

      // Başarılı uyarı göster
      Get.snackbar(
        'Başarılı',
        'Kayıt işlemi tamamlandı!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Login ekranına yönlendir
      Get.offAllNamed('/login'); // Tüm stack'i temizleyip yönlendirir
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Beklenmeyen bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createUserProfile(String userId) async {
    await _firestore.collection('users').doc(userId).set({
      'name': nameController.text.trim(),
      'surname': surnameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'email-already-in-use':
        message = 'Bu e-posta adresi zaten kullanımda';
        break;
      case 'weak-password':
        message = 'Şifre çok zayıf';
        break;
      case 'invalid-email':
        message = 'Geçersiz e-posta adresi';
        break;
      default:
        message = 'Bir hata oluştu: ${e.message}';
    }
    Get.snackbar(
      'Hata',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
