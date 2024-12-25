// phone_verification_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _auth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  String? _verificationId;
  bool _codeSent = false;
  bool _isLoading = false;

  Future<void> _verifyPhone() async {
    setState(() => _isLoading = true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+90${_phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAllNamed('/home');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Hata', e.message ?? 'Bir hata oluştu',
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _codeSent = true;
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      Get.snackbar('Hata', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      Get.offAllNamed('/home');
    } catch (e) {
      setState(() => _isLoading = false);
      Get.snackbar('Hata', 'Geçersiz kod', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telefon Doğrulama'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_codeSent) ...[
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
                  border: OutlineInputBorder(),
                  prefixText: '+90 ',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyPhone,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Kod Gönder'),
                ),
              ),
            ] else ...[
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Doğrulama Kodu',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOTP,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Doğrula'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
