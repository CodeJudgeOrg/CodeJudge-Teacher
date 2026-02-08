import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @submissions.
  ///
  /// In en, this message translates to:
  /// **'Submissions'**
  String get submissions;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// No description provided for @noteDifficultyLevel.
  ///
  /// In en, this message translates to:
  /// **'Level of difficulty: '**
  String get noteDifficultyLevel;

  /// No description provided for @newExercise.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newExercise;

  /// No description provided for @addExercise.
  ///
  /// In en, this message translates to:
  /// **'Add a new exercise'**
  String get addExercise;

  /// No description provided for @editExercise.
  ///
  /// In en, this message translates to:
  /// **'Edit an exercise'**
  String get editExercise;

  /// No description provided for @hintEnterName.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get hintEnterName;

  /// No description provided for @hintEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get hintEnterDescription;

  /// No description provided for @hintEnterTask.
  ///
  /// In en, this message translates to:
  /// **'Task:'**
  String get hintEnterTask;

  /// No description provided for @hintEnterSolution.
  ///
  /// In en, this message translates to:
  /// **'Solution:'**
  String get hintEnterSolution;

  /// No description provided for @selectDifficultyLevel.
  ///
  /// In en, this message translates to:
  /// **'Level of difficulty:'**
  String get selectDifficultyLevel;

  /// No description provided for @simpleLevel.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get simpleLevel;

  /// No description provided for @mediumLevel.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get mediumLevel;

  /// No description provided for @difficultLevel.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get difficultLevel;

  /// No description provided for @hintEnterHint.
  ///
  /// In en, this message translates to:
  /// **'Hint:'**
  String get hintEnterHint;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode:'**
  String get themeMode;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// No description provided for @localisationMode.
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get localisationMode;

  /// No description provided for @localeEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get localeEnglish;

  /// No description provided for @localeGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get localeGerman;

  /// No description provided for @aboutThisButton.
  ///
  /// In en, this message translates to:
  /// **'About this project'**
  String get aboutThisButton;

  /// No description provided for @reportABugButton.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get reportABugButton;

  /// No description provided for @requestAFeatureButton.
  ///
  /// In en, this message translates to:
  /// **'Request a feature'**
  String get requestAFeatureButton;

  /// No description provided for @seeLicenseButton.
  ///
  /// In en, this message translates to:
  /// **'See the license'**
  String get seeLicenseButton;

  /// No description provided for @seeReleasesButton.
  ///
  /// In en, this message translates to:
  /// **'See all releases'**
  String get seeReleasesButton;

  /// No description provided for @aboutMeButton.
  ///
  /// In en, this message translates to:
  /// **'About the developer'**
  String get aboutMeButton;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
