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

class App extends StatelessWidget {
  const App({required this.localeController, super.key});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeController),
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
      child: Consumer<LocaleController>(
        builder: (context, localeController, _) => MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          locale: localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SplashView(),
        ),
      ),
    );
  }
}
