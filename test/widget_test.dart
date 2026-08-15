import 'package:business_app/features/booking/views/booking_view.dart';
import 'package:business_app/features/home/views/home_view.dart';
import 'package:business_app/features/invites/views/invite_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home view shows hospitality brand title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));

    expect(find.text('Harbor & Haven'), findsOneWidget);
    expect(find.text('Boutique stays for effortless escapes'), findsOneWidget);
  });

  testWidgets('booking view shows suite selection and pricing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BookingView()));

    expect(find.text('Book your stay'), findsOneWidget);
    expect(find.text('Harbor Loft'), findsOneWidget);
    expect(find.text('AED 620 / night'), findsOneWidget);
  });

  testWidgets('invite view shows referral flow', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: InviteView()));

    expect(find.text('Invite friends'), findsOneWidget);
    expect(find.text('Share your referral code'), findsOneWidget);
  });
}
