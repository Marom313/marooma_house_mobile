import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/booking_view_model.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<BookingViewModel>(context, listen: false);
      vm.loadAvailableSuites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book your stay'),
        backgroundColor: const Color(0xFF1B3D35),
        foregroundColor: Colors.white,
      ),
      body: Consumer<BookingViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text('Error: ${vm.error}'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Suites',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                ...vm.availableSuites.map((suite) => _SuiteCard(suite: suite)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SuiteCard extends StatelessWidget {
  const _SuiteCard({required this.suite});

  final dynamic suite;

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suite.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2A33),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  suite.subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF60707C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  suite.description,
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
                      'AED ${suite.pricePerNight.toStringAsFixed(0)} / night',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE8B45F),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final vm = Provider.of<BookingViewModel>(context, listen: false);
                        vm.selectSuite(suite);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${suite.title} selected')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B3D35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Select'),
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
