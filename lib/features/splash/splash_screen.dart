import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upfit/core/themes/app_colors.dart';
import 'package:upfit/features/home/home_screen.dart';
import 'package:upfit/features/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animasyon kontrolcüsünü başlat
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Firebase Authentication kontrolü
    Future.delayed(Duration(seconds: 3), _checkUserStatus);
  }

  void _checkUserStatus() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Kullanıcı giriş yapmışsa HomeScreen'e yönlendir
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Kullanıcı giriş yapmamışsa LoginScreen'e yönlendir
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Icon(
                Icons.fitness_center,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              // Uygulama adı
              Text(
                'UpFit',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
