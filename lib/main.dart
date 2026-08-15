import 'package:flutter/material.dart';
import 'app/bootstrap.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await AppBootstrap.initialize();
    runApp(const App());
  } catch (e, st) {
    // If bootstrap fails, run a minimal error app
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Initialization error: $e')))));
  }
}
