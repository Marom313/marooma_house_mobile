import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../booking_model/booking.dart';
import '../booking_model/suite.dart';

class BookingService {
  FirebaseFirestore? get _firestore =>
      Firebase.apps.isNotEmpty ? FirebaseFirestore.instance : null;

  static const String suiteCollection = 'suites';
  static const String bookingCollection = 'bookings';

  static final List<Suite> _fallbackSuites = [
    Suite(
      id: 'harbor-loft',
      title: 'Harbor Loft',
      subtitle: 'Ocean-view suite · 2 guests',
      description:
          'Stunning sea views with modern luxury finishes and private terrace.',
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
      description:
          'Spacious garden-facing suite perfect for families and groups.',
      pricePerNight: 840,
      maxGuests: 4,
      amenities: [
        'WiFi',
        'Pool Access',
        'Garden View',
        'Kitchen',
        'Multiple Bedrooms',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=900&q=80',
      location: 'Garden District',
    ),
    Suite(
      id: 'pearl-suite',
      title: 'The Pearl Suite',
      subtitle: 'Light-filled boutique suite · 2 guests',
      description:
          'An intimate, sunlit suite with soft coastal finishes and a quiet reading corner.',
      pricePerNight: 710,
      maxGuests: 2,
      amenities: ['WiFi', 'AC', 'Breakfast', 'Reading Corner', 'Rain Shower'],
      imageUrl:
          'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1200&q=85',
      location: 'East Wing',
    ),
    Suite(
      id: 'lighthouse-suite',
      title: 'The Lighthouse Suite',
      subtitle: 'Hilltop panoramic suite · 2 guests',
      description:
          'Our highest suite, with sweeping coastal views, a private balcony, and sunset seating.',
      pricePerNight: 960,
      maxGuests: 2,
      amenities: [
        'WiFi',
        'AC',
        'Panoramic View',
        'Private Balcony',
        'Mini Bar',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=85',
      location: 'Hilltop',
    ),
    Suite(
      id: 'garden-room',
      title: 'Garden Room',
      subtitle: 'Comfort room · 2 guests',
      description:
          'A calm and comfortable room with direct garden access and everything needed for an easy stay.',
      pricePerNight: 390,
      maxGuests: 2,
      amenities: ['WiFi', 'AC', 'Garden Access', 'Coffee Station', 'Smart TV'],
      imageUrl:
          'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=1200&q=85',
      location: 'Garden Level',
    ),
    Suite(
      id: 'family-room',
      title: 'Family Room',
      subtitle: 'Spacious family room · 5 guests',
      description:
          'A generous family room with flexible sleeping space, a lounge area, and practical storage.',
      pricePerNight: 760,
      maxGuests: 5,
      amenities: ['WiFi', 'AC', 'Family Lounge', 'Mini Fridge', 'Extra Beds'],
      imageUrl:
          'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=1200&q=85',
      location: 'Courtyard Wing',
    ),
  ];

  // Get all available suites
  Future<List<Suite>> getAvailableSuites() async {
    final firestore = _firestore;
    if (firestore == null) {
      return List.unmodifiable(_fallbackSuites);
    }

    try {
      final snapshot = await firestore.collection(suiteCollection).get();
      final remoteSuites = snapshot.docs
          .map((doc) => Suite.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
      final remoteById = {for (final suite in remoteSuites) suite.id: suite};
      final catalogIds = _fallbackSuites.map((suite) => suite.id).toSet();

      return [
        for (final suite in _fallbackSuites) remoteById[suite.id] ?? suite,
        ...remoteSuites.where((suite) => !catalogIds.contains(suite.id)),
      ];
    } catch (e) {
      throw Exception('Failed to fetch suites: $e');
    }
  }

  // Get a single suite by ID
  Future<Suite?> getSuiteById(String suiteId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return _fallbackSuites.where((suite) => suite.id == suiteId).firstOrNull;
    }

    try {
      final doc = await firestore
          .collection(suiteCollection)
          .doc(suiteId)
          .get();
      if (doc.exists) {
        return Suite.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
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
    final firestore = _firestore;
    if (firestore == null) {
      throw Exception('Firebase not initialized');
    }

    try {
      final booking = Booking(
        id: firestore.collection(bookingCollection).doc().id,
        userId: userId,
        suiteId: suiteId,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        numberOfGuests: numberOfGuests,
        totalPrice: totalPrice,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await firestore
          .collection(bookingCollection)
          .doc(booking.id)
          .set(booking.toJson());
      return booking;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  // Get user's bookings
  Future<List<Booking>> getUserBookings(String userId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return [];
    }

    try {
      final snapshot = await firestore
          .collection(bookingCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Booking.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user bookings: $e');
    }
  }

  // Confirm a booking
  Future<void> confirmBooking(String bookingId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return;
    }

    try {
      await firestore.collection(bookingCollection).doc(bookingId).update({
        'status': 'confirmed',
      });
    } catch (e) {
      throw Exception('Failed to confirm booking: $e');
    }
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    final firestore = _firestore;
    if (firestore == null) {
      return;
    }

    try {
      await firestore.collection(bookingCollection).doc(bookingId).update({
        'status': 'cancelled',
      });
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  // Initialize default suites if collection is empty
  Future<void> initializeDefaultSuites() async {
    final firestore = _firestore;
    if (firestore == null) {
      return;
    }

    try {
      final collection = firestore.collection(suiteCollection);
      final snapshot = await collection.get();
      final existingIds = snapshot.docs.map((doc) => doc.id).toSet();

      for (final suite in _fallbackSuites) {
        if (!existingIds.contains(suite.id)) {
          await collection.doc(suite.id).set(suite.toJson());
        }
      }
    } catch (e) {
      throw Exception('Failed to initialize default suites: $e');
    }
  }
}
