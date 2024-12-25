import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfit/core/themes/app_colors.dart';
import 'package:upfit/features/login/login_screen.dart';
import 'package:upfit/features/signUp/signUp_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "UpFit'e Kayıt Ol",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                _buildInputField(
                  controller: controller.nameController,
                  label: 'Ad',
                  validator: (value) =>
                      value!.isEmpty ? 'Lütfen adınızı girin' : null,
                ),
                _buildInputField(
                  controller: controller.surnameController,
                  label: 'Soyad',
                  validator: (value) =>
                      value!.isEmpty ? 'Lütfen soyadınızı girin' : null,
                ),
                _buildInputField(
                  controller: controller.emailController,
                  label: 'E-posta',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => !GetUtils.isEmail(value!)
                      ? 'Geçerli bir e-posta adresi girin'
                      : null,
                ),
                // _buildInputField(
                //   controller: controller.phoneController,
                //   label: 'Telefon',
                //   prefixText: '+90 ',
                //   keyboardType: TextInputType.phone,
                //   validator: (value) => value!.length != 10
                //       ? 'Geçerli bir telefon numarası girin'
                //       : null,
                // ),
                _buildInputField(
                  controller: controller.passwordController,
                  label: 'Şifre',
                  isPassword: true,
                  validator: (value) => value!.length < 6
                      ? 'Şifre en az 6 karakter olmalı'
                      : null,
                ),
                SizedBox(height: 20),
                Obx(() => Container(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isLoading.value
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: AppColors.kPrimary,
                              )
                            : Text('Kayıt Ol'),
                      ),
                    )),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabın Var mı? "),
                    GestureDetector(
                      onTap: () => Get.to(() => LoginScreen()),
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    String? prefixText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixText: prefixText,
        ),
        validator: validator,
      ),
    );
  }
}
