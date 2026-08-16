import 'package:get_it/get_it.dart';
import '../features/authentication/services/firebase_auth_service.dart';
import '../features/authentication/authentication_view_model/auth_view_model.dart';
import '../features/booking/services/booking_service.dart';
import '../features/booking/booking_view_model/booking_view_model.dart';
import '../features/invites/services/invite_service.dart';
import '../features/invites/invites_view_model/invite_view_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDi() async {
  // Auth Services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // Booking Services
  getIt.registerLazySingleton<BookingService>(() => BookingService());

  // Invite Services
  getIt.registerLazySingleton<InviteService>(() => InviteService());

  // ViewModels (factory so each provider gets its own instance)
  getIt.registerFactory<AuthViewModel>(
    () => AuthViewModel(authService: getIt<FirebaseAuthService>()),
  );

  getIt.registerFactory<BookingViewModel>(
    () => BookingViewModel(bookingService: getIt<BookingService>()),
  );

  getIt.registerFactory<InviteViewModel>(
    () => InviteViewModel(inviteService: getIt<InviteService>()),
  );
}
