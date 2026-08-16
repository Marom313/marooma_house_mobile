import 'package:flutter/foundation.dart';

import '../invites_model/invitation.dart';
import '../services/invite_service.dart';

class InviteViewModel extends ChangeNotifier {
  final InviteService _inviteService;

  List<Invitation> _sentInvitations = [];
  List<Invitation> _activeInvitations = [];
  bool _isLoading = false;
  String? _error;
  String? _lastGeneratedCode;

  InviteViewModel({required this._inviteService});

  List<Invitation> get sentInvitations => _sentInvitations;
  List<Invitation> get activeInvitations => _activeInvitations;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get lastGeneratedCode => _lastGeneratedCode;

  Future<void> loadSentInvitations(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sentInvitations = await _inviteService.getUserSentInvitations(userId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadActiveInvitations(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _activeInvitations = await _inviteService.getActiveInvitations(userId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Invitation?> createInvitation({
    required String userId,
    required String userName,
    required String userEmail,
    String? recipientEmail,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final invitation = await _inviteService.createInvitation(
        senderId: userId,
        senderName: userName,
        senderEmail: userEmail,
        recipientEmail: recipientEmail,
      );

      _lastGeneratedCode = invitation.referralCode;
      _sentInvitations.insert(0, invitation);

      _isLoading = false;
      notifyListeners();
      return invitation;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> acceptInvitation(String referralCode, String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _inviteService.acceptInvitation(referralCode, userId);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
