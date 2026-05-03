import 'package:flutter/material.dart';
import 'package:investor_app/core/utils/session_manager.dart';
import 'package:investor_app/presentation/screens/home_screen.dart';
import 'package:investor_app/presentation/screens/login_screen.dart';
import 'package:investor_app/utils/ui_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    bool isLoggedIn = await SessionManager.isLoggedIn();

    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: UiUtils.screenWidth(context), // 👈 full width
        height: UiUtils.screenHeight(context), // 👈 full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA5D6A7), Color(0xFFF5F7F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: UiUtils.responsivePadding(
              context,
            ), // 👈 responsive padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 💰 App Icon
                Container(
                  height: UiUtils.responsiveHeight(
                    context,
                    25,
                  ), // 👈 responsive
                  width: UiUtils.responsiveWidth(context, 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      UiUtils.responsiveWidth(context, 5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        blurRadius: UiUtils.responsiveWidth(context, 5),
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    "assets/investors/inv2.jpg",
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: UiUtils.responsiveHeight(context, 3)),

                // 🔤 App Name
                Text(
                  "InvestGrow",
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(
                      context,
                      28,
                    ), // 👈 responsive
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

                // Subtitle
                Text(
                  "Watch your investment grow",
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(
                      context,
                      14,
                    ), // 👈 responsive
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: UiUtils.responsiveHeight(context, 5)),

                // ⏳ Loader
                SizedBox(
                  height: UiUtils.responsiveWidth(context, 8),
                  width: UiUtils.responsiveWidth(context, 8),
                  child: const CircularProgressIndicator(
                    color: Color(0xFF2E7D32),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
