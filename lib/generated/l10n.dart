// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `no internet title`
  String get label_common_internet_connection_error_title {
    return Intl.message(
      'no internet title',
      name: 'label_common_internet_connection_error_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_common_internet_connection_error_body {
    return Intl.message(
      '',
      name: 'label_common_internet_connection_error_body',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_common_button_back_title {
    return Intl.message(
      '',
      name: 'label_common_button_back_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_general_api_exception_title {
    return Intl.message(
      '',
      name: 'label_general_api_exception_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_general_api_exception_message {
    return Intl.message(
      '',
      name: 'label_general_api_exception_message',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_general_api_exception_button_retry {
    return Intl.message(
      '',
      name: 'label_general_api_exception_button_retry',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_common_button_cancel {
    return Intl.message(
      '',
      name: 'label_common_button_cancel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_screen_title {
    return Intl.message(
      '',
      name: 'label_menu_screen_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_item_help_title {
    return Intl.message(
      '',
      name: 'label_menu_item_help_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_item_settings_title {
    return Intl.message(
      '',
      name: 'label_menu_item_settings_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_item_about_app_title {
    return Intl.message(
      '',
      name: 'label_menu_item_about_app_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_settings_screen_title {
    return Intl.message(
      '',
      name: 'label_menu_settings_screen_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_screen_title {
    return Intl.message(
      '',
      name: 'label_menu_about_screen_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_app_name {
    return Intl.message(
      '',
      name: 'label_menu_about_app_name',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_app_published_by {
    return Intl.message(
      '',
      name: 'label_menu_about_app_published_by',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_app_published_address {
    return Intl.message(
      '',
      name: 'label_menu_about_app_published_address',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_action_privacy_title {
    return Intl.message(
      '',
      name: 'label_menu_about_action_privacy_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_action_terms_and_conditions_title {
    return Intl.message(
      '',
      name: 'label_menu_about_action_terms_and_conditions_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_action_third_party_licenses_title {
    return Intl.message(
      '',
      name: 'label_menu_about_action_third_party_licenses_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_screen_title {
    return Intl.message(
      '',
      name: 'label_menu_help_screen_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_action_call_text {
    return Intl.message(
      '',
      name: 'label_menu_help_action_call_text',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_action_contact_form_title {
    return Intl.message(
      '',
      name: 'label_menu_help_action_contact_form_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_action_contact_form_text {
    return Intl.message(
      '',
      name: 'label_menu_help_action_contact_form_text',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_action_faq_title {
    return Intl.message(
      '',
      name: 'label_menu_help_action_faq_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_help_action_faq_text {
    return Intl.message(
      '',
      name: 'label_menu_help_action_faq_text',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_about_third_party_screen_title {
    return Intl.message(
      '',
      name: 'label_menu_about_third_party_screen_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_settings_other_title {
    return Intl.message(
      '',
      name: 'label_menu_settings_other_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_menu_settings_language_title {
    return Intl.message(
      '',
      name: 'label_menu_settings_language_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get label_onboarding_biometrics_permission_dialog_text {
    return Intl.message(
      '',
      name: 'label_onboarding_biometrics_permission_dialog_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
