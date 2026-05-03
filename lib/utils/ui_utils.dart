import 'package:flutter/material.dart';

/// Utility functions for UI operations and responsive design
class UiUtils {
  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get screen size
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get status bar height
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get bottom safe area height
  static double bottomSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// Check if device is tablet (width >= 600)
  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= 600;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }

  /// Get responsive font size based on screen width
  static double responsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = UiUtils.screenWidth(context);
    final scaleFactor = screenWidth / 375.0; // iPhone 6/7/8 width as base
    return baseSize * scaleFactor.clamp(0.8, 1.5);
  }

  /// Get responsive width based on screen width
  static double responsiveWidth(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }

  /// Get responsive height based on screen height
  static double responsiveHeight(BuildContext context, double percentage) {
    return screenHeight(context) * (percentage / 100);
  }

  /// Get horizontal padding based on screen size
  static double horizontalPadding(BuildContext context) {
    return isTablet(context) ? 24.0 : 16.0;
  }

  /// Get vertical padding based on screen size
  static double verticalPadding(BuildContext context) {
    return isTablet(context) ? 24.0 : 12.0;
  }

  /// Create responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    final padding = isTablet(context) ? 24.0 : 16.0;
    return EdgeInsets.all(padding);
  }

  /// Create symmetric responsive padding
  static EdgeInsets responsiveSymmetricPadding(
    BuildContext context, {
    double horizontal = 16.0,
    double vertical = 8.0,
  }) {
    final hPadding = isTablet(context) ? horizontal * 1.5 : horizontal;
    final vPadding = isTablet(context) ? vertical * 1.5 : vertical;
    return EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding);
  }

  /// Get responsive icon size
  static double responsiveIconSize(BuildContext context, double baseSize) {
    return responsiveFontSize(context, baseSize);
  }

  /// Show snackbar with message
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Show success snackbar
  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: Colors.green);
  }

  /// Show error snackbar
  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: Colors.red);
  }

  /// Show loading dialog
  static void showLoadingDialog(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Show confirmation dialog
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Show custom dialog
  static Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// Get theme colors
  static ColorScheme colorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  /// Get text theme
  static TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  /// Create responsive text style
  static TextStyle responsiveTextStyle(
    BuildContext context,
    TextStyle baseStyle,
  ) {
    final fontSize = responsiveFontSize(context, baseStyle.fontSize ?? 14.0);
    return baseStyle.copyWith(fontSize: fontSize);
  }

  /// Get keyboard height
  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return keyboardHeight(context) > 0;
  }

  /// Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Get device orientation
  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return orientation(context) == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return orientation(context) == Orientation.portrait;
  }

  /// Get aspect ratio
  static double aspectRatio(BuildContext context) {
    final size = screenSize(context);
    return size.width / size.height;
  }

  /// Create responsive container
  static Widget responsiveContainer({
    required BuildContext context,
    required Widget child,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Decoration? decoration,
  }) {
    return Container(
      width: width != null ? responsiveWidth(context, width) : null,
      height: height != null ? responsiveHeight(context, height) : null,
      padding: padding ?? responsivePadding(context),
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }

  /// Create responsive sized box
  static Widget responsiveSizedBox({
    required BuildContext context,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width != null ? responsiveWidth(context, width) : null,
      height: height != null ? responsiveHeight(context, height) : null,
    );
  }

  /// Get platform brightness
  static Brightness platformBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  /// Check if device is in dark mode
  static bool isDarkMode(BuildContext context) {
    return platformBrightness(context) == Brightness.dark;
  }

  /// Get safe area padding
  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Create fade transition
  static Widget fadeTransition({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      child: child,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Create slide transition
  static Widget slideTransition({
    required Widget child,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: end),
      duration: duration,
      builder: (context, offset, child) {
        return Transform.translate(offset: offset, child: child);
      },
      child: child,
    );
  }
}
