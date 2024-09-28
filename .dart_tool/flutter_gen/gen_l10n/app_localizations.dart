import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Youtube en'**
  String get appName;

  /// No description provided for @createShort.
  ///
  /// In en, this message translates to:
  /// **'Create short'**
  String get createShort;

  /// No description provided for @uploadAVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload a video'**
  String get uploadAVideo;

  /// No description provided for @fromFiles.
  ///
  /// In en, this message translates to:
  /// **'From files'**
  String get fromFiles;

  /// No description provided for @fromExternalSources.
  ///
  /// In en, this message translates to:
  /// **'From external sources'**
  String get fromExternalSources;

  /// No description provided for @videoUrl.
  ///
  /// In en, this message translates to:
  /// **'Video URL'**
  String get videoUrl;

  /// No description provided for @addThumbnailOfYourVideo.
  ///
  /// In en, this message translates to:
  /// **'Add thumbnail of your video'**
  String get addThumbnailOfYourVideo;

  /// No description provided for @addThumbnailOfYourShorts.
  ///
  /// In en, this message translates to:
  /// **'Add thumbnail of your shorts'**
  String get addThumbnailOfYourShorts;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @selectCategories.
  ///
  /// In en, this message translates to:
  /// **'Select categories'**
  String get selectCategories;

  /// No description provided for @hashtag.
  ///
  /// In en, this message translates to:
  /// **'Hashtag'**
  String get hashtag;

  /// No description provided for @selectAVisibility.
  ///
  /// In en, this message translates to:
  /// **'Select a visibility'**
  String get selectAVisibility;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @uploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload video'**
  String get uploadVideo;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @addDetails.
  ///
  /// In en, this message translates to:
  /// **'Add details'**
  String get addDetails;

  /// No description provided for @addThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Add thumbnail'**
  String get addThumbnail;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @reportContent.
  ///
  /// In en, this message translates to:
  /// **'Report content'**
  String get reportContent;

  /// No description provided for @violentContent.
  ///
  /// In en, this message translates to:
  /// **'Violent content'**
  String get violentContent;

  /// No description provided for @hatefulContent.
  ///
  /// In en, this message translates to:
  /// **'Hateful content'**
  String get hatefulContent;

  /// No description provided for @harmfulContent.
  ///
  /// In en, this message translates to:
  /// **'Harmful content'**
  String get harmfulContent;

  /// No description provided for @spam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get spam;

  /// No description provided for @childAbuse.
  ///
  /// In en, this message translates to:
  /// **'Child abuse'**
  String get childAbuse;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @viewChannel.
  ///
  /// In en, this message translates to:
  /// **'view channel'**
  String get viewChannel;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @yourVideos.
  ///
  /// In en, this message translates to:
  /// **'Your videos'**
  String get yourVideos;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @getCineplexPremium.
  ///
  /// In en, this message translates to:
  /// **'Get Cineplex Premium'**
  String get getCineplexPremium;

  /// No description provided for @helpAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'Help & feedback'**
  String get helpAndFeedback;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @shorts.
  ///
  /// In en, this message translates to:
  /// **'Shorts'**
  String get shorts;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @editMyChannel.
  ///
  /// In en, this message translates to:
  /// **'Edit my channel'**
  String get editMyChannel;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @yourPlans.
  ///
  /// In en, this message translates to:
  /// **'Your plans'**
  String get yourPlans;

  /// No description provided for @clearWatchHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear watched history'**
  String get clearWatchHistory;

  /// No description provided for @rateOurApp.
  ///
  /// In en, this message translates to:
  /// **'Rate our app'**
  String get rateOurApp;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get inviteFriends;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions'**
  String get termsAndConditions;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpAndSupport;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @updateChannel.
  ///
  /// In en, this message translates to:
  /// **'UpdateChannel'**
  String get updateChannel;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @channelUrl.
  ///
  /// In en, this message translates to:
  /// **'Channel URL'**
  String get channelUrl;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID:'**
  String get transactionId;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method:'**
  String get paymentMethod;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan:'**
  String get plan;

  /// No description provided for @timePeriod.
  ///
  /// In en, this message translates to:
  /// **'Time period'**
  String get timePeriod;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get needHelp;

  /// No description provided for @helpAndSupportInfoText.
  ///
  /// In en, this message translates to:
  /// **'We\'re here to help with any questions or issues you may have.'**
  String get helpAndSupportInfoText;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @enterYourQuery.
  ///
  /// In en, this message translates to:
  /// **'Enter your query'**
  String get enterYourQuery;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @noKeepIt.
  ///
  /// In en, this message translates to:
  /// **'No, Keep it'**
  String get noKeepIt;

  /// No description provided for @yesDeleteIt.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete it!'**
  String get yesDeleteIt;

  /// No description provided for @confirmDeleteText.
  ///
  /// In en, this message translates to:
  /// **'You\'re going to delete your account. Are you sure?'**
  String get confirmDeleteText;

  /// No description provided for @createNewPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Create new playlist'**
  String get createNewPlaylist;

  /// No description provided for @noShortsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No shorts available'**
  String get noShortsAvailable;

  /// No description provided for @noVideosDownloadedYet.
  ///
  /// In en, this message translates to:
  /// **'No videos downloaded yet'**
  String get noVideosDownloadedYet;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Notifications not available'**
  String get notificationsNotAvailable;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribe;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @forYou.
  ///
  /// In en, this message translates to:
  /// **'For you'**
  String get forYou;

  /// No description provided for @videoNotFound.
  ///
  /// In en, this message translates to:
  /// **'Videos not found!!'**
  String get videoNotFound;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more;

  /// No description provided for @addAComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addAComment;

  /// No description provided for @failToPickVideo.
  ///
  /// In en, this message translates to:
  /// **'Fail to pick video'**
  String get failToPickVideo;

  /// No description provided for @signInWithAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign-in with account'**
  String get signInWithAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @byClickingCreateAccountYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'By clicking Create account you agree to our '**
  String get byClickingCreateAccountYouAgreeToOur;

  /// No description provided for @termsAndUse.
  ///
  /// In en, this message translates to:
  /// **'Terms and use'**
  String get termsAndUse;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @youAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'You agree to our'**
  String get youAgreeToOur;

  /// No description provided for @andAcknowledgeOur.
  ///
  /// In en, this message translates to:
  /// **'and acknowledge our'**
  String get andAcknowledgeOur;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @toResetYourPasswordPleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'ToResetYourPasswordPleaseEnterYourEmail'**
  String get toResetYourPasswordPleaseEnterYourEmail;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @createStrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password that has at least 8 characters long.'**
  String get createStrongPassword;

  /// No description provided for @token.
  ///
  /// In en, this message translates to:
  /// **'Token'**
  String get token;

  /// No description provided for @welcomeChief.
  ///
  /// In en, this message translates to:
  /// **'Welcome chief'**
  String get welcomeChief;

  /// No description provided for @pleaseEnterYourNameAndPhoneNumberToLogIn.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name and phone number to log in'**
  String get pleaseEnterYourNameAndPhoneNumberToLogIn;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @weHaveSendAnOtpOnGivenNumber.
  ///
  /// In en, this message translates to:
  /// **'We have send an OTP on given number'**
  String get weHaveSendAnOtpOnGivenNumber;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCode;

  /// No description provided for @saveToPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Save to playlist'**
  String get saveToPlaylist;

  /// No description provided for @downloadVideo.
  ///
  /// In en, this message translates to:
  /// **'Download video'**
  String get downloadVideo;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
