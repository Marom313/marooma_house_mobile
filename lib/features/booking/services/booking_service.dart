import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/booking.dart';
import '../models/suite.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String suiteCollection = 'suites';
  static const String bookingCollection = 'bookings';

  // Get all available suites
  Future<List<Suite>> getAvailableSuites() async {
    try {
      final snapshot = await _firestore.collection(suiteCollection).get();
      return snapshot.docs.map((doc) => Suite.fromJson({...doc.data(), 'id': doc.id})).toList();
    } catch (e) {
      throw Exception('Failed to fetch suites: $e');
    }
  }

  // Get a single suite by ID
  Future<Suite?> getSuiteById(String suiteId) async {
    try {
      final doc = await _firestore.collection(suiteCollection).doc(suiteId).get();
      if (doc.exists) {
        return Suite.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch suite: $e');
    }
  }

  // Create a new booking
  Future<Booking> createBooking({
    required String userId,
    required String suiteId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int numberOfGuests,
    required double totalPrice,
  }) async {
    try {
      final booking = Booking(
        id: _firestore.collection(bookingCollection).doc().id,
        userId: userId,
        suiteId: suiteId,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        numberOfGuests: numberOfGuests,
        totalPrice: totalPrice,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _firestore.collection(bookingCollection).doc(booking.id).set(booking.toJson());
      return booking;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  // Get user's bookings
  Future<List<Booking>> getUserBookings(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(bookingCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => Booking.fromJson({...doc.data(), 'id': doc.id})).toList();
    } catch (e) {
      throw Exception('Failed to fetch user bookings: $e');
    }
  }

  // Confirm a booking
  Future<void> confirmBooking(String bookingId) async {
    try {
      await _firestore.collection(bookingCollection).doc(bookingId).update({'status': 'confirmed'});
    } catch (e) {
      throw Exception('Failed to confirm booking: $e');
    }
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _firestore.collection(bookingCollection).doc(bookingId).update({'status': 'cancelled'});
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  // Initialize default suites if collection is empty
  Future<void> initializeDefaultSuites() async {
    try {
      final existing = await _firestore.collection(suiteCollection).limit(1).get();
      if (existing.docs.isNotEmpty) return;

      final defaultSuites = [
        Suite(
          id: 'harbor-loft',
          title: 'Harbor Loft',
          subtitle: 'Ocean-view suite · 2 guests',
          description: 'Stunning sea views with modern luxury finishes and private terrace.',
          pricePerNight: 620,
          maxGuests: 2,
          amenities: ['WiFi', 'AC', 'Sea View', 'Private Terrace', 'Mini Bar'],
          imageUrl:
              'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80',
          location: 'Coastal Area',
        ),
        Suite(
          id: 'courtyard-casa',
          title: 'Courtyard Casa',
          subtitle: 'Garden retreat · 4 guests',
          description: 'Spacious garden-facing suite perfect for families and groups.',
          pricePerNight: 840,
          maxGuests: 4,
          amenities: ['WiFi', 'Pool Access', 'Garden View', 'Kitchen', 'Multiple Bedrooms'],
          imageUrl:
              'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=900&q=80',
          location: 'Garden District',
        ),
      ];

      for (final suite in defaultSuites) {
        await _firestore.collection(suiteCollection).doc(suite.id).set(suite.toJson());
      }
    } catch (e) {
      throw Exception('Failed to initialize default suites: $e');
    }
  }
}
