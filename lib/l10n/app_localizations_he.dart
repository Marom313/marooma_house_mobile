// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appName => 'בית מרומה';

  @override
  String get tagline => 'אירוח בוטיק לחופשה בלי מאמץ';

  @override
  String get openMenu => 'פתיחת תפריט';

  @override
  String get home => 'בית';

  @override
  String get bookStay => 'הזמנת אירוח';

  @override
  String get inviteFriends => 'הזמנת חברים';

  @override
  String get exploreStays => 'לגלות אירוחים';

  @override
  String get accountSettings => 'הגדרות חשבון';

  @override
  String get language => 'שפה';

  @override
  String get systemLanguage => 'שפת המכשיר';

  @override
  String get english => 'אנגלית';

  @override
  String get hebrew => 'עברית';

  @override
  String get russian => 'רוסית';

  @override
  String get signatureSeasons => 'עונות מיוחדות';

  @override
  String get signatureBody =>
      'יוקרה רגועה, שלווה על החוף ואירוח יפהפה ללא מאמץ.';

  @override
  String get curatedLiving => 'חיים על החוף שנבחרו בקפידה';

  @override
  String get heroTitle => 'להתארח יפה. להתמלא מחדש.';

  @override
  String get heroBody =>
      'סוויטות שטופות שמש, חוויות מקומיות ויוקרה איטית שמתאימה לאופן שבו באמת מטיילים.';

  @override
  String get peopleLovingIt => 'חוויות שאנשים אוהבים';

  @override
  String get featuredEscapes => 'אירוחים נבחרים';

  @override
  String get sunsetBrunch => 'בראנץ׳ בשקיעה';

  @override
  String get poolsideLaughs => 'רגעים ליד הבריכה';

  @override
  String get beachDinners => 'ארוחות על החוף';

  @override
  String get friendsGuests => 'חברים · 4 אורחים';

  @override
  String get couplesGuests => 'זוגות · 2 אורחים';

  @override
  String get familiesGuests => 'משפחות · 6 אורחים';

  @override
  String get harborLoft => 'לופט הנמל';

  @override
  String get courtyardCasa => 'בית החצר';

  @override
  String get oceanSuiteGuests => 'סוויטה מול הים · 2 אורחים';

  @override
  String get gardenRetreatGuests => 'אירוח בגינה · 4 אורחים';

  @override
  String get harborLoftDescription =>
      'נוף מרהיב לים, עיצוב יוקרתי מודרני ומרפסת פרטית.';

  @override
  String get courtyardCasaDescription =>
      'סוויטה מרווחת הפונה לגינה, מושלמת למשפחות ולקבוצות.';

  @override
  String get pearlSuite => 'סוויטת הפנינה';

  @override
  String get pearlSuiteSubtitle => 'סוויטת בוטיק מוארת · 2 אורחים';

  @override
  String get pearlSuiteDescription =>
      'סוויטה אינטימית ושטופת שמש, בעיצוב חופי רך ועם פינת קריאה שקטה.';

  @override
  String get lighthouseSuite => 'סוויטת המגדלור';

  @override
  String get lighthouseSuiteSubtitle => 'סוויטה פנורמית על הגבעה · 2 אורחים';

  @override
  String get lighthouseSuiteDescription =>
      'הסוויטה הגבוהה ביותר שלנו, עם נוף חוף רחב, מרפסת פרטית ופינת ישיבה לשקיעה.';

  @override
  String get gardenRoom => 'חדר הגן';

  @override
  String get gardenRoomSubtitle => 'חדר נוח · 2 אורחים';

  @override
  String get gardenRoomDescription =>
      'חדר רגוע ונוח עם יציאה ישירה לגינה וכל מה שצריך לשהייה נעימה.';

  @override
  String get familyRoom => 'חדר משפחתי';

  @override
  String get familyRoomSubtitle => 'חדר משפחתי מרווח · 5 אורחים';

  @override
  String get familyRoomDescription =>
      'חדר משפחתי נדיב עם סידורי שינה גמישים, אזור ישיבה ואחסון שימושי.';

  @override
  String nightPrice(String price) {
    return '$price דירהם ללילה';
  }

  @override
  String get bookTitle => 'הזמנת האירוח שלכם';

  @override
  String get availableSuites => 'חדרים וסוויטות';

  @override
  String get select => 'בחירה';

  @override
  String suiteSelected(String suite) {
    return '$suite נבחרה';
  }

  @override
  String errorMessage(String message) {
    return 'שגיאה: $message';
  }

  @override
  String get shareReferral => 'שתפו את קוד ההפניה שלכם';

  @override
  String get referralBody => 'הזמינו חברים וקבלו 10% הנחה בהזמנה הבאה.';

  @override
  String get generateReferral => 'יצירת קוד הפניה';

  @override
  String get invitationCreated => 'ההזמנה נוצרה. העתיקו את הקוד למטה.';

  @override
  String copiedCode(String code) {
    return 'הועתק: $code';
  }

  @override
  String get inviteByEmail => 'או להזמין בדוא״ל';

  @override
  String get emailHint => 'friend@example.com';

  @override
  String get invitationSent => 'ההזמנה נשלחה!';

  @override
  String get sendInvitation => 'שליחת הזמנה';

  @override
  String get sentInvitations => 'הזמנות שנשלחו';

  @override
  String get noInvitations => 'עדיין לא נשלחו הזמנות';

  @override
  String get discount => '10% הנחה';

  @override
  String get pending => 'בהמתנה';

  @override
  String get accepted => 'אושרה';

  @override
  String initializationError(String message) {
    return 'שגיאת אתחול: $message';
  }
}
