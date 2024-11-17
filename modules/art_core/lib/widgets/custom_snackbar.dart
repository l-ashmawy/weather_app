import 'package:art_core/art_core.dart';
import 'package:core/core.dart';

void showSnackBar(String text, {bool isError = false}) {
  ScaffoldMessenger.of(
    Modular.routerDelegate.navigatorKey.currentContext!,
  ).showSnackBar(SnackBar(
    content: AppText(
      text: text,
      color: Colors.white,
      maxLines: 3,
    ),
    backgroundColor: isError ? Colors.red : AppColors.primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    duration: const Duration(seconds: 3),
  ));
}
