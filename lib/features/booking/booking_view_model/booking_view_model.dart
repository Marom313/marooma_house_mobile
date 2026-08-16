import 'package:flutter/foundation.dart';

import '../booking_model/booking.dart';
import '../booking_model/suite.dart';
import '../services/booking_service.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingService _bookingService;

  List<Suite> _availableSuites = [];
  Suite? _selectedSuite;
  bool _isLoading = false;
  String? _error;

  BookingViewModel({required this._bookingService});

  List<Suite> get availableSuites => _availableSuites;
  Suite? get selectedSuite => _selectedSuite;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAvailableSuites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _availableSuites = await _bookingService.getAvailableSuites();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectSuite(Suite suite) {
    _selectedSuite = suite;
    notifyListeners();
  }

  Future<Booking?> createBooking({
    required String userId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int numberOfGuests,
  }) async {
    if (_selectedSuite == null) {
      _error = 'Please select a suite';
      notifyListeners();
      return null;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final daysStay = checkOutDate.difference(checkInDate).inDays;
      final totalPrice = _selectedSuite!.pricePerNight * daysStay;

      final booking = await _bookingService.createBooking(
        userId: userId,
        suiteId: _selectedSuite!.id,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        numberOfGuests: numberOfGuests,
        totalPrice: totalPrice,
      );

      _isLoading = false;
      notifyListeners();
      return booking;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> initializeDefaults() async {
    try {
      await _bookingService.initializeDefaultSuites();
      await loadAvailableSuites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
