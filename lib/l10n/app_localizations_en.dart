// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Marooma House';

  @override
  String get tagline => 'Boutique stays for effortless escapes';

  @override
  String get openMenu => 'Open menu';

  @override
  String get home => 'Home';

  @override
  String get bookStay => 'Book a stay';

  @override
  String get inviteFriends => 'Invite friends';

  @override
  String get exploreStays => 'Explore stays';

  @override
  String get accountSettings => 'Account settings';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System language';

  @override
  String get english => 'English';

  @override
  String get hebrew => 'Hebrew';

  @override
  String get russian => 'Russian';

  @override
  String get signatureSeasons => 'Signature seasons';

  @override
  String get signatureBody =>
      'Slow luxury, coastal calm, and beautifully effortless stays.';

  @override
  String get curatedLiving => 'Curated coastal living';

  @override
  String get heroTitle => 'Stay beautifully. Feel restored.';

  @override
  String get heroBody =>
      'Sun-kissed suites, local experiences, and slower luxury for the way you actually travel.';

  @override
  String get peopleLovingIt => 'People loving it';

  @override
  String get featuredEscapes => 'Featured escapes';

  @override
  String get sunsetBrunch => 'Sunset brunch';

  @override
  String get poolsideLaughs => 'Poolside laughs';

  @override
  String get beachDinners => 'Beach dinners';

  @override
  String get friendsGuests => 'Friends · 4 guests';

  @override
  String get couplesGuests => 'Couples · 2 guests';

  @override
  String get familiesGuests => 'Families · 6 guests';

  @override
  String get harborLoft => 'Harbor Loft';

  @override
  String get courtyardCasa => 'Courtyard Casa';

  @override
  String get oceanSuiteGuests => 'Ocean-view suite · 2 guests';

  @override
  String get gardenRetreatGuests => 'Garden retreat · 4 guests';

  @override
  String get harborLoftDescription =>
      'Stunning sea views with modern luxury finishes and a private terrace.';

  @override
  String get courtyardCasaDescription =>
      'A spacious garden-facing suite, perfect for families and groups.';

  @override
  String get pearlSuite => 'The Pearl Suite';

  @override
  String get pearlSuiteSubtitle => 'Light-filled boutique suite · 2 guests';

  @override
  String get pearlSuiteDescription =>
      'An intimate, sunlit suite with soft coastal finishes and a quiet reading corner.';

  @override
  String get lighthouseSuite => 'The Lighthouse Suite';

  @override
  String get lighthouseSuiteSubtitle => 'Hilltop panoramic suite · 2 guests';

  @override
  String get lighthouseSuiteDescription =>
      'Our highest suite, with sweeping coastal views, a private balcony, and sunset seating.';

  @override
  String get gardenRoom => 'Garden Room';

  @override
  String get gardenRoomSubtitle => 'Comfort room · 2 guests';

  @override
  String get gardenRoomDescription =>
      'A calm and comfortable room with direct garden access and everything needed for an easy stay.';

  @override
  String get familyRoom => 'Family Room';

  @override
  String get familyRoomSubtitle => 'Spacious family room · 5 guests';

  @override
  String get familyRoomDescription =>
      'A generous family room with flexible sleeping space, a lounge area, and practical storage.';

  @override
  String nightPrice(String price) {
    return 'AED $price / night';
  }

  @override
  String get bookTitle => 'Book your stay';

  @override
  String get availableSuites => 'Rooms and suites';

  @override
  String get select => 'Select';

  @override
  String suiteSelected(String suite) {
    return '$suite selected';
  }

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get shareReferral => 'Share your referral code';

  @override
  String get referralBody =>
      'Invite friends and earn 10% off your next booking.';

  @override
  String get generateReferral => 'Generate referral code';

  @override
  String get invitationCreated => 'Invitation created. Copy the code below.';

  @override
  String copiedCode(String code) {
    return 'Copied: $code';
  }

  @override
  String get inviteByEmail => 'Or invite via email';

  @override
  String get emailHint => 'friend@example.com';

  @override
  String get invitationSent => 'Invitation sent!';

  @override
  String get sendInvitation => 'Send invitation';

  @override
  String get sentInvitations => 'Sent invitations';

  @override
  String get noInvitations => 'No invitations sent yet';

  @override
  String get discount => '10% off';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String initializationError(String message) {
    return 'Initialization error: $message';
  }
}
