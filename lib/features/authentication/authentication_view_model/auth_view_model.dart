import 'package:flutter/foundation.dart';
import '../services/firebase_auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService authService;

  bool _isLoading = false;
  String? _userId;

  AuthViewModel({required this.authService});

  bool get isLoading => _isLoading;
  String? get userId => _userId;

  Future<void> checkSession() async {
    _isLoading = true;
    notifyListeners();
    final uid = await authService.currentUserId();
    _userId = uid;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    _userId = null;
    notifyListeners();
  }
}
