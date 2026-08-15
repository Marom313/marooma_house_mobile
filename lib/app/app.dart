import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../app/di.dart';
import '../core/theme/app_theme.dart';
import '../features/authentication/services/firebase_auth_service.dart';
import '../features/authentication/view_models/auth_view_model.dart';
import '../features/authentication/views/splash_view.dart';
import '../features/booking/view_models/booking_view_model.dart';
import '../features/invites/view_models/invite_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) {
            if (getIt.isRegistered<AuthViewModel>()) {
              return getIt<AuthViewModel>();
            }
            return AuthViewModel(
              authService: FirebaseAuthService(),
            );
          },
        ),
        ChangeNotifierProvider<BookingViewModel>(
          create: (_) => getIt<BookingViewModel>(),
        ),
        ChangeNotifierProvider<InviteViewModel>(
          create: (_) => getIt<InviteViewModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Business App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('he'), Locale('ru')],
        home: const SplashView(),
      ),
    );
  }
}
