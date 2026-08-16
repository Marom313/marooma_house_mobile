import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/di.dart';
import '../core/theme/app_theme.dart';
import '../features/authentication/services/firebase_auth_service.dart';
import '../features/authentication/authentication_view/splash_view.dart';
import '../features/authentication/authentication_view_model/auth_view_model.dart';
import '../features/booking/booking_view_model/booking_view_model.dart';
import '../features/invites/invites_view_model/invite_view_model.dart';
import '../l10n/app_localizations.dart';
import 'locale_controller.dart';
import 'theme_controller.dart';

class App extends StatelessWidget {
  const App({
    required this.localeController,
    required this.themeController,
    super.key,
  });

  final LocaleController localeController;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeController),
        ChangeNotifierProvider.value(value: themeController),
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) {
            if (getIt.isRegistered<AuthViewModel>()) {
              return getIt<AuthViewModel>();
            }
            return AuthViewModel(authService: FirebaseAuthService());
          },
        ),
        ChangeNotifierProvider<BookingViewModel>(
          create: (_) => getIt<BookingViewModel>(),
        ),
        ChangeNotifierProvider<InviteViewModel>(
          create: (_) => getIt<InviteViewModel>(),
        ),
      ],
      child: Consumer2<LocaleController, ThemeController>(
        builder: (context, localeController, themeController, _) => MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          locale: localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SplashView(),
        ),
      ),
    );
  }
}
