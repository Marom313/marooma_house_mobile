import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'app/locale_controller.dart';
import 'app/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await AppBootstrap.initialize();
    final preferences = await SharedPreferences.getInstance();
    runApp(
      App(
        localeController: LocaleController(preferences),
        themeController: ThemeController(preferences),
      ),
    );
  } catch (error) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Initialization error: $error')),
        ),
      ),
    );
  }
}
