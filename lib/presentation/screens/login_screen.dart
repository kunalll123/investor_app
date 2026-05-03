import 'package:flutter/material.dart';
import 'package:investor_app/core/utils/session_manager.dart';

import 'package:investor_app/presentation/screens/home_screen.dart';
import 'package:investor_app/utils/ui_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: UiUtils.screenWidth(context),
        height: UiUtils.screenHeight(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA5D6A7), Color(0xFFF5F7F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: UiUtils.responsivePadding(context), // 👈 responsive padding
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 👋 Heading
                  Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 30),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ),

                  SizedBox(height: UiUtils.responsiveHeight(context, 1)),

                  Center(
                    child: Text(
                      "Login to your investment account",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 14),
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  SizedBox(height: UiUtils.responsiveHeight(context, 5)),

                  /// 📧 Email Field
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: UiUtils.responsiveWidth(context, 4),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        UiUtils.responsiveWidth(context, 8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.1),
                          blurRadius: UiUtils.responsiveWidth(context, 4),
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 14),
                      ),
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: UiUtils.responsiveIconSize(context, 22),
                          color: const Color(0xFF2E7D32),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: UiUtils.responsiveHeight(context, 2),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: UiUtils.responsiveHeight(context, 2.5)),

                  /// 🔐 Password Field
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: UiUtils.responsiveWidth(context, 4),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        UiUtils.responsiveWidth(context, 8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.1),
                          blurRadius: UiUtils.responsiveWidth(context, 4),
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 14),
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          size: UiUtils.responsiveIconSize(context, 22),
                          color: const Color(0xFF2E7D32),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: UiUtils.responsiveHeight(context, 2),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: UiUtils.responsiveHeight(context, 4)),

                  /// 🚀 Login Button
                  SizedBox(
                    width: double.infinity,
                    height: UiUtils.responsiveHeight(context, 7),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            UiUtils.responsiveWidth(context, 8),
                          ),
                        ),
                        elevation: 8,
                      ),
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          await SessionManager.saveLogin(emailController.text);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        } else {
                          UiUtils.showErrorSnackBar(
                            context,
                            "Enter credentials",
                          );
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: UiUtils.responsiveFontSize(context, 16),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: UiUtils.responsiveHeight(context, 2.5)),

                  /// 🔗 Footer
                  Center(
                    child: Text(
                      "Secure & Trusted Investment",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: UiUtils.responsiveFontSize(context, 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
