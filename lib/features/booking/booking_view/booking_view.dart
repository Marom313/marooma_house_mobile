import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../services/booking_service.dart';
import '../booking_view_model/booking_view_model.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late final BookingViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = BookingViewModel(bookingService: BookingService());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.loadAvailableSuites();
    });
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _vm,
      builder: (context, _) {
        if (_vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_vm.error != null) {
          return Scaffold(
            body: Center(child: Text(strings.errorMessage('${_vm.error}'))),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(strings.bookTitle),
            backgroundColor: const Color(0xFF1B3D35),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.availableSuites,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                ..._vm.availableSuites.map(
                  (suite) => _SuiteCard(suite: suite, vm: _vm),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SuiteCard extends StatelessWidget {
  const _SuiteCard({required this.suite, required this.vm});

  final dynamic suite;
  final BookingViewModel vm;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final suiteTitle = switch (suite.id) {
      'harbor-loft' => strings.harborLoft,
      'courtyard-casa' => strings.courtyardCasa,
      'pearl-suite' => strings.pearlSuite,
      'lighthouse-suite' => strings.lighthouseSuite,
      'garden-room' => strings.gardenRoom,
      'family-room' => strings.familyRoom,
      _ => suite.title as String,
    };
    final suiteSubtitle = switch (suite.id) {
      'harbor-loft' => strings.oceanSuiteGuests,
      'courtyard-casa' => strings.gardenRetreatGuests,
      'pearl-suite' => strings.pearlSuiteSubtitle,
      'lighthouse-suite' => strings.lighthouseSuiteSubtitle,
      'garden-room' => strings.gardenRoomSubtitle,
      'family-room' => strings.familyRoomSubtitle,
      _ => suite.subtitle as String,
    };
    final suiteDescription = switch (suite.id) {
      'harbor-loft' => strings.harborLoftDescription,
      'courtyard-casa' => strings.courtyardCasaDescription,
      'pearl-suite' => strings.pearlSuiteDescription,
      'lighthouse-suite' => strings.lighthouseSuiteDescription,
      'garden-room' => strings.gardenRoomDescription,
      'family-room' => strings.familyRoomDescription,
      _ => suite.description as String,
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              suite.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suiteTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2A33),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  suiteSubtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF60707C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  suiteDescription,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF60707C),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strings.nightPrice(
                        suite.pricePerNight.toStringAsFixed(0),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE8B45F),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        vm.selectSuite(suite);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(strings.suiteSelected(suiteTitle)),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B3D35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(strings.select),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
