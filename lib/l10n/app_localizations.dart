import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_he.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('he'),
    Locale('ru'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Marooma House'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Boutique stays for effortless escapes'**
  String get tagline;

  /// No description provided for @openMenu.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get openMenu;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bookStay.
  ///
  /// In en, this message translates to:
  /// **'Book a stay'**
  String get bookStay;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get inviteFriends;

  /// No description provided for @exploreStays.
  ///
  /// In en, this message translates to:
  /// **'Explore stays'**
  String get exploreStays;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get systemLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hebrew.
  ///
  /// In en, this message translates to:
  /// **'Hebrew'**
  String get hebrew;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @signatureSeasons.
  ///
  /// In en, this message translates to:
  /// **'Signature seasons'**
  String get signatureSeasons;

  /// No description provided for @signatureBody.
  ///
  /// In en, this message translates to:
  /// **'Slow luxury, coastal calm, and beautifully effortless stays.'**
  String get signatureBody;

  /// No description provided for @curatedLiving.
  ///
  /// In en, this message translates to:
  /// **'Curated coastal living'**
  String get curatedLiving;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay beautifully. Feel restored.'**
  String get heroTitle;

  /// No description provided for @heroBody.
  ///
  /// In en, this message translates to:
  /// **'Sun-kissed suites, local experiences, and slower luxury for the way you actually travel.'**
  String get heroBody;

  /// No description provided for @peopleLovingIt.
  ///
  /// In en, this message translates to:
  /// **'People loving it'**
  String get peopleLovingIt;

  /// No description provided for @featuredEscapes.
  ///
  /// In en, this message translates to:
  /// **'Featured escapes'**
  String get featuredEscapes;

  /// No description provided for @sunsetBrunch.
  ///
  /// In en, this message translates to:
  /// **'Sunset brunch'**
  String get sunsetBrunch;

  /// No description provided for @poolsideLaughs.
  ///
  /// In en, this message translates to:
  /// **'Poolside laughs'**
  String get poolsideLaughs;

  /// No description provided for @beachDinners.
  ///
  /// In en, this message translates to:
  /// **'Beach dinners'**
  String get beachDinners;

  /// No description provided for @friendsGuests.
  ///
  /// In en, this message translates to:
  /// **'Friends · 4 guests'**
  String get friendsGuests;

  /// No description provided for @couplesGuests.
  ///
  /// In en, this message translates to:
  /// **'Couples · 2 guests'**
  String get couplesGuests;

  /// No description provided for @familiesGuests.
  ///
  /// In en, this message translates to:
  /// **'Families · 6 guests'**
  String get familiesGuests;

  /// No description provided for @harborLoft.
  ///
  /// In en, this message translates to:
  /// **'Harbor Loft'**
  String get harborLoft;

  /// No description provided for @courtyardCasa.
  ///
  /// In en, this message translates to:
  /// **'Courtyard Casa'**
  String get courtyardCasa;

  /// No description provided for @oceanSuiteGuests.
  ///
  /// In en, this message translates to:
  /// **'Ocean-view suite · 2 guests'**
  String get oceanSuiteGuests;

  /// No description provided for @gardenRetreatGuests.
  ///
  /// In en, this message translates to:
  /// **'Garden retreat · 4 guests'**
  String get gardenRetreatGuests;

  /// No description provided for @harborLoftDescription.
  ///
  /// In en, this message translates to:
  /// **'Stunning sea views with modern luxury finishes and a private terrace.'**
  String get harborLoftDescription;

  /// No description provided for @courtyardCasaDescription.
  ///
  /// In en, this message translates to:
  /// **'A spacious garden-facing suite, perfect for families and groups.'**
  String get courtyardCasaDescription;

  /// No description provided for @pearlSuite.
  ///
  /// In en, this message translates to:
  /// **'The Pearl Suite'**
  String get pearlSuite;

  /// No description provided for @pearlSuiteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Light-filled boutique suite · 2 guests'**
  String get pearlSuiteSubtitle;

  /// No description provided for @pearlSuiteDescription.
  ///
  /// In en, this message translates to:
  /// **'An intimate, sunlit suite with soft coastal finishes and a quiet reading corner.'**
  String get pearlSuiteDescription;

  /// No description provided for @lighthouseSuite.
  ///
  /// In en, this message translates to:
  /// **'The Lighthouse Suite'**
  String get lighthouseSuite;

  /// No description provided for @lighthouseSuiteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hilltop panoramic suite · 2 guests'**
  String get lighthouseSuiteSubtitle;

  /// No description provided for @lighthouseSuiteDescription.
  ///
  /// In en, this message translates to:
  /// **'Our highest suite, with sweeping coastal views, a private balcony, and sunset seating.'**
  String get lighthouseSuiteDescription;

  /// No description provided for @gardenRoom.
  ///
  /// In en, this message translates to:
  /// **'Garden Room'**
  String get gardenRoom;

  /// No description provided for @gardenRoomSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Comfort room · 2 guests'**
  String get gardenRoomSubtitle;

  /// No description provided for @gardenRoomDescription.
  ///
  /// In en, this message translates to:
  /// **'A calm and comfortable room with direct garden access and everything needed for an easy stay.'**
  String get gardenRoomDescription;

  /// No description provided for @familyRoom.
  ///
  /// In en, this message translates to:
  /// **'Family Room'**
  String get familyRoom;

  /// No description provided for @familyRoomSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Spacious family room · 5 guests'**
  String get familyRoomSubtitle;

  /// No description provided for @familyRoomDescription.
  ///
  /// In en, this message translates to:
  /// **'A generous family room with flexible sleeping space, a lounge area, and practical storage.'**
  String get familyRoomDescription;

  /// No description provided for @nightPrice.
  ///
  /// In en, this message translates to:
  /// **'AED {price} / night'**
  String nightPrice(String price);

  /// No description provided for @bookTitle.
  ///
  /// In en, this message translates to:
  /// **'Book your stay'**
  String get bookTitle;

  /// No description provided for @availableSuites.
  ///
  /// In en, this message translates to:
  /// **'Rooms and suites'**
  String get availableSuites;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @suiteSelected.
  ///
  /// In en, this message translates to:
  /// **'{suite} selected'**
  String suiteSelected(String suite);

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(String message);

  /// No description provided for @shareReferral.
  ///
  /// In en, this message translates to:
  /// **'Share your referral code'**
  String get shareReferral;

  /// No description provided for @referralBody.
  ///
  /// In en, this message translates to:
  /// **'Invite friends and earn 10% off your next booking.'**
  String get referralBody;

  /// No description provided for @generateReferral.
  ///
  /// In en, this message translates to:
  /// **'Generate referral code'**
  String get generateReferral;

  /// No description provided for @invitationCreated.
  ///
  /// In en, this message translates to:
  /// **'Invitation created. Copy the code below.'**
  String get invitationCreated;

  /// No description provided for @copiedCode.
  ///
  /// In en, this message translates to:
  /// **'Copied: {code}'**
  String copiedCode(String code);

  /// No description provided for @inviteByEmail.
  ///
  /// In en, this message translates to:
  /// **'Or invite via email'**
  String get inviteByEmail;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'friend@example.com'**
  String get emailHint;

  /// No description provided for @invitationSent.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent!'**
  String get invitationSent;

  /// No description provided for @sendInvitation.
  ///
  /// In en, this message translates to:
  /// **'Send invitation'**
  String get sendInvitation;

  /// No description provided for @sentInvitations.
  ///
  /// In en, this message translates to:
  /// **'Sent invitations'**
  String get sentInvitations;

  /// No description provided for @noInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations sent yet'**
  String get noInvitations;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'10% off'**
  String get discount;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @initializationError.
  ///
  /// In en, this message translates to:
  /// **'Initialization error: {message}'**
  String initializationError(String message);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'he', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
