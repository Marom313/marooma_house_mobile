import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'di.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await setupDi();
    // Additional initialization: logging, secure storage warmup, localization preload
  }
}
