import 'package:marooma_house_mobile/app/locale_controller.dart';
import 'package:marooma_house_mobile/app/theme_controller.dart';
import 'package:marooma_house_mobile/features/booking/booking_view/booking_view.dart';
import 'package:marooma_house_mobile/features/home/home_view/home_view.dart';
import 'package:marooma_house_mobile/features/invites/invites_view/invite_view.dart';
import 'package:marooma_house_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpLocalized(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
}) async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleController(preferences)),
        ChangeNotifierProvider(create: (_) => ThemeController(preferences)),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('home view shows localized brand title', (tester) async {
    await pumpLocalized(tester, const HomeView());

    expect(find.text('Marooma House'), findsWidgets);
    expect(find.text('Boutique stays for effortless escapes'), findsOneWidget);
    await tester.ensureVisible(find.text('Rooms and suites'));
    await tester.pumpAndSettle();
    expect(find.text('The Pearl Suite'), findsOneWidget);
    expect(find.text('The Lighthouse Suite'), findsOneWidget);
    expect(find.text('Garden Room'), findsOneWidget);
    expect(find.text('Family Room'), findsOneWidget);
  });

  testWidgets('right menu exposes account settings and preferences', (
    tester,
  ) async {
    await pumpLocalized(tester, const HomeView());

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold).first);
    scaffold.openEndDrawer();
    await tester.pumpAndSettle();

    expect(scaffold.isEndDrawerOpen, isTrue);
    expect(find.text('Account settings'), findsOneWidget);

    await tester.tap(find.text('Account settings'));
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
  });

  testWidgets('mobile room catalog uses a horizontal row', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpLocalized(tester, const HomeView());
    await tester.ensureVisible(find.text('Rooms and suites'));
    await tester.pumpAndSettle();

    final horizontalLists = find.byWidgetPredicate(
      (widget) =>
          widget is ListView && widget.scrollDirection == Axis.horizontal,
    );
    expect(horizontalLists, findsWidgets);
  });

  testWidgets('booking view shows localized suite selection and pricing', (
    tester,
  ) async {
    await pumpLocalized(tester, const BookingView());

    expect(find.text('Book your stay'), findsOneWidget);
    expect(find.text('Harbor Loft'), findsOneWidget);
    expect(find.text('AED 620 / night'), findsOneWidget);
    expect(find.text('The Pearl Suite'), findsOneWidget);
    expect(find.text('The Lighthouse Suite'), findsOneWidget);
    expect(find.text('Garden Room'), findsOneWidget);
    expect(find.text('Family Room'), findsOneWidget);
  });

  testWidgets('invite view shows localized referral flow', (tester) async {
    await pumpLocalized(tester, const InviteView());

    expect(find.text('Invite friends'), findsOneWidget);
    expect(find.text('Share your referral code'), findsOneWidget);
  });

  testWidgets('Hebrew locale applies RTL and translated content', (
    tester,
  ) async {
    await pumpLocalized(tester, const HomeView(), locale: const Locale('he'));

    expect(find.text('בית מרומה'), findsWidgets);
    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);
  });

  testWidgets('Russian locale displays translated content', (tester) async {
    await pumpLocalized(tester, const HomeView(), locale: const Locale('ru'));

    expect(find.text('Любимые впечатления'), findsOneWidget);
  });
}
