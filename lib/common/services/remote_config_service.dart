import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:food_for_family/common/services/base/base_service.dart';

const String _faqNL = 'nl_webview_faq';
const String _faqEN = 'en_webview_faq';

const String _gcNL = 'nl_webview_general_conditions';
const String _gcEN = 'en_webview_general_conditions';

const String _privacyNL = 'nl_webview_privacy_declarations';
const String _privacyEN = 'en_webview_privacy_declarations';

const String _contactFormNL = 'nl_webview_contact_form';
const String _contactFormEN = 'en_webview_contact_form';

const String _contactPhoneNumberNL = 'nl_contact_phone_number';
const String _contactPhoneNumberEN = 'en_contact_phone_number';

class RemoteConfigService extends BaseService {
  final FirebaseRemoteConfig _remoteConfig;

  Map<String, String> get _faq => {
        'nl': _remoteConfig.getString(_faqNL),
        'en': _remoteConfig.getString(_faqEN),
      };

  Map<String, String> get _generalConditions => {
        'nl': _remoteConfig.getString(_gcNL),
        'en': _remoteConfig.getString(_gcEN),
      };

  Map<String, String> get _privacy => {
        'nl': _remoteConfig.getString(_privacyNL),
        'en': _remoteConfig.getString(_privacyEN),
      };

  Map<String, String> get _contactForm => {
        'nl': _remoteConfig.getString(_contactFormNL),
        'en': _remoteConfig.getString(_contactFormEN),
      };

  Map<String, String> get _contactPhoneNumber => {
        'nl': _remoteConfig.getString(_contactPhoneNumberNL),
        'en': _remoteConfig.getString(_contactPhoneNumberEN),
      };

  // Defaults
  final defaults = <String, dynamic>{
    _faqNL: 'https://#/',
    _faqEN: 'https://#/',
    _gcNL: 'https://#/',
    _gcEN: 'https://#/',
    _privacyNL: 'https://#/',
    _privacyEN: 'https://#/',
    _contactFormNL: 'https://#/',
    _contactFormEN: 'https://#/',
    _contactPhoneNumberNL: '',
    _contactPhoneNumberEN: '',
  };

  static RemoteConfigService? _instance;

  static Future<RemoteConfigService> getInstance() async {
    _instance ??= RemoteConfigService(
      remoteConfig: FirebaseRemoteConfig.instance,
    );

    return _instance!;
  }

  RemoteConfigService({required FirebaseRemoteConfig remoteConfig}) : _remoteConfig = remoteConfig;

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);

      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(milliseconds: 1),
        minimumFetchInterval: const Duration(milliseconds: 1),
      ));

      await _fetchRemoteConfig();
    } catch (exception) {
      logger.error(
          'Unable to fetch remote config. Cached or default values will be '
          'used',
          stack: StackTrace.current);
    }
  }

  String getFaq(String languageCode) {
    return _faq[languageCode]!;
  }

  String getGeneralConditions(String languageCode) {
    return _generalConditions[languageCode]!;
  }

  String getPrivacy(String languageCode) {
    return _privacy[languageCode]!;
  }

  String getContactForm(String languageCode) {
    return _contactForm[languageCode]!;
  }

  String getContactPhoneNumber(String languageCode) {
    return _contactPhoneNumber[languageCode]!;
  }

  Future<void> _fetchRemoteConfig() async {
    try {
      await _remoteConfig.fetch();
      await _remoteConfig.activate();

      logger.info('Last fetch status: ${_remoteConfig.lastFetchStatus}');
      logger.info('Last fetch time: ${_remoteConfig.lastFetchTime}');
    } catch (e) {
      logger.error(e, stack: StackTrace.current);
    }
  }
}
