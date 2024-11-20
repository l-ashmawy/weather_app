import 'dart:async';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('weather');

  runApp(
    ModularApp(
      debugMode: false,
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
