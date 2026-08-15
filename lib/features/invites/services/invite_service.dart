import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invitation.dart';

class InviteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String invitationCollection = 'invitations';

  // Generate a unique referral code
  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch.toString().substring(5);
    return (random + chars[DateTime.now().millisecond % chars.length]).substring(0, 8);
  }

  // Create an invitation
  Future<Invitation> createInvitation({
    required String senderId,
    required String senderName,
    required String senderEmail,
    String? recipientEmail,
  }) async {
    try {
      final referralCode = _generateReferralCode();
      final invitation = Invitation(
        id: _firestore.collection(invitationCollection).doc().id,
        senderId: senderId,
        senderName: senderName,
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        referralCode: referralCode,
        createdAt: DateTime.now(),
        status: 'pending',
        referralReward: 10, // 10% discount
      );

      await _firestore.collection(invitationCollection).doc(invitation.id).set(invitation.toJson());
      return invitation;
    } catch (e) {
      throw Exception('Failed to create invitation: $e');
    }
  }

  // Get user's sent invitations
  Future<List<Invitation>> getUserSentInvitations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(invitationCollection)
          .where('senderId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => Invitation.fromJson({...doc.data(), 'id': doc.id})).toList();
    } catch (e) {
      throw Exception('Failed to fetch sent invitations: $e');
    }
  }

  // Accept an invitation via referral code
  Future<void> acceptInvitation(String referralCode, String userId) async {
    try {
      final snapshot = await _firestore
          .collection(invitationCollection)
          .where('referralCode', isEqualTo: referralCode)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Invalid referral code');
      }

      final doc = snapshot.docs.first;
      await _firestore
          .collection(invitationCollection)
          .doc(doc.id)
          .update({'status': 'accepted', 'acceptedAt': DateTime.now().toIso8601String()});
    } catch (e) {
      throw Exception('Failed to accept invitation: $e');
    }
  }

  // Get all active invitations for a user
  Future<List<Invitation>> getActiveInvitations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(invitationCollection)
          .where('senderId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .get();

      return snapshot.docs.map((doc) => Invitation.fromJson({...doc.data(), 'id': doc.id})).toList();
    } catch (e) {
      throw Exception('Failed to fetch active invitations: $e');
    }
  }
}
