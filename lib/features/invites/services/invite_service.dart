import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../invites_model/invitation.dart';

class InviteService {
  FirebaseFirestore? get _firestore =>
      Firebase.apps.isNotEmpty ? FirebaseFirestore.instance : null;

  static const String invitationCollection = 'invitations';
  static final List<Invitation> _fallbackInvitations = [];

  // Generate a unique referral code
  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch.toString().substring(
      5,
    );
    return (random + chars[DateTime.now().millisecond % chars.length])
        .substring(0, 8);
  }

  // Create an invitation
  Future<Invitation> createInvitation({
    required String senderId,
    required String senderName,
    required String senderEmail,
    String? recipientEmail,
  }) async {
    final firestore = _firestore;
    if (firestore == null) {
      final referralCode = _generateReferralCode();
      final invitation = Invitation(
        id: 'demo-${DateTime.now().millisecondsSinceEpoch}',
        senderId: senderId,
        senderName: senderName,
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        referralCode: referralCode,
        createdAt: DateTime.now(),
        status: 'pending',
        referralReward: 10,
      );
      _fallbackInvitations.insert(0, invitation);
      return invitation;
    }

    try {
      final referralCode = _generateReferralCode();
      final invitation = Invitation(
        id: firestore.collection(invitationCollection).doc().id,
        senderId: senderId,
        senderName: senderName,
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        referralCode: referralCode,
        createdAt: DateTime.now(),
        status: 'pending',
        referralReward: 10,
      );

      await firestore
          .collection(invitationCollection)
          .doc(invitation.id)
          .set(invitation.toJson());
      return invitation;
    } catch (e) {
      throw Exception('Failed to create invitation: $e');
    }
  }

  // Get user's sent invitations
  Future<List<Invitation>> getUserSentInvitations(String userId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return _fallbackInvitations
          .where((invitation) => invitation.senderId == userId)
          .toList();
    }

    try {
      final snapshot = await firestore
          .collection(invitationCollection)
          .where('senderId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Invitation.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch sent invitations: $e');
    }
  }

  // Accept an invitation via referral code
  Future<void> acceptInvitation(String referralCode, String userId) async {
    final firestore = _firestore;
    if (firestore == null) {
      final match = _fallbackInvitations
          .where((invitation) => invitation.referralCode == referralCode)
          .firstOrNull;
      if (match == null) {
        throw Exception('Invalid referral code');
      }
      final index = _fallbackInvitations.indexOf(match);
      _fallbackInvitations[index] = Invitation(
        id: match.id,
        senderId: match.senderId,
        senderName: match.senderName,
        senderEmail: match.senderEmail,
        recipientEmail: match.recipientEmail,
        referralCode: match.referralCode,
        createdAt: match.createdAt,
        status: 'accepted',
        acceptedAt: DateTime.now(),
        referralReward: match.referralReward,
      );
      return;
    }

    try {
      final snapshot = await firestore
          .collection(invitationCollection)
          .where('referralCode', isEqualTo: referralCode)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Invalid referral code');
      }

      final doc = snapshot.docs.first;
      await firestore.collection(invitationCollection).doc(doc.id).update({
        'status': 'accepted',
        'acceptedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to accept invitation: $e');
    }
  }

  // Get all active invitations for a user
  Future<List<Invitation>> getActiveInvitations(String userId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return _fallbackInvitations
          .where(
            (invitation) =>
                invitation.senderId == userId && invitation.status == 'pending',
          )
          .toList();
    }

    try {
      final snapshot = await firestore
          .collection(invitationCollection)
          .where('senderId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .get();

      return snapshot.docs
          .map((doc) => Invitation.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch active invitations: $e');
    }
  }
}
