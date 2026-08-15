import 'package:get_it/get_it.dart';
import '../features/authentication/services/firebase_auth_service.dart';
import '../features/authentication/view_models/auth_view_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDi() async {
  // Services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // ViewModels (factory so each provider gets its own instance)
  getIt.registerFactory<AuthViewModel>(() => AuthViewModel(authService: getIt<FirebaseAuthService>()));
}
