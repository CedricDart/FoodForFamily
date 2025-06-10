import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const _maintenanceMessagesShown = 'maintenanceMessagesShown';
  static const _language = 'language';
  static const _onboardingShown = 'onboardingShown';
  static const _stationMode = 'stationMode';
  static const _biometricsEnabled = 'biometricsEnabled';
  static const _fuelFilters = 'fuelFilters';
  static const _chargeFilters = 'chargeFilters';
  static const _activeOperationalTransaction = 'activeOperationalTransaction';
  static const _geolocationSoftQuestionAsked = 'geolocationSoftQuestionAsked';
  static const _feedbackSkipped = 'feedbackSkipped';
  static const _completeDeviceActivationBottomsheetShown = 'completeDeviceActivationBottomsheetShown';
  static const _lastVersionFeaturesOnboardingShown = 'lastVersionFeaturesOnboardingShown';
  static const _lastBackgroundedTime = 'lastBackgroundedTime';

  static const _feedbackLastPresentationVersion = 'feedbackLastPresentationVersion';
  static const _feedbackChargingDisplayCount = 'feedbackChargingDisplayCount';
  static const _feedbackFuelingDisplayCount = 'feedbackFuelingDisplayCount';

  static const _feedbackChargingSuccessfulSessionCount = 'feedbackChargingSuccessfulSessionCount';
  static const _feedbackFuelingSuccessfulSessionCount = 'feedbackFuelingSuccessfulSessionCount';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setMaintenanceMessageShown(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<String> maintenanceIdsShown = prefs.getStringList(_maintenanceMessagesShown) ?? [];
    maintenanceIdsShown.add(id);
    prefs.setStringList(_maintenanceMessagesShown, maintenanceIdsShown);
  }

  Future<bool> isMaintenanceMessageShown(String id) {
    return _prefs.then((SharedPreferences prefs) {
      List<String> maintenanceIdsShown = prefs.getStringList(_maintenanceMessagesShown) ?? [];
      return maintenanceIdsShown.contains(id);
    });
  }

  Future<void> setCompleteDeviceActivationBottomsheetShown(bool isShown) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(_completeDeviceActivationBottomsheetShown, isShown);
  }

  Future<bool> isCompleteDeviceActivationBottomsheetShown() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_completeDeviceActivationBottomsheetShown) ?? false;
    });
  }

  Future<void> setOnboardingShown(bool isShown) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(_onboardingShown, isShown);
  }

  Future<bool> isOnboardingShown() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_onboardingShown) ?? false;
    });
  }

  Future<void> setGeolocationSoftQuestionAsked(bool isShown) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(_geolocationSoftQuestionAsked, isShown);
  }

  Future<bool> isGeolocationSoftQuestionAsked() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_geolocationSoftQuestionAsked) ?? false;
    });
  }

  void setLanguage(String languageCode) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_language, languageCode);
  }

  Future<String> getLanguage() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(_language) ?? '';
    });
  }

  Future<void> setLastVersionFeaturesOnboardingShown(String version) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_lastVersionFeaturesOnboardingShown, version);
  }

  Future<String> getLastVersionFeaturesOnboardingShown() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(_lastVersionFeaturesOnboardingShown) ?? '';
    });
  }

  Future<bool> setBiometricsEnabled(bool isEnabled) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(_biometricsEnabled, isEnabled);
  }

  Future<bool> isBiometricsEnabled() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_biometricsEnabled) ?? false;
    });
  }

  Future<bool> setFeedbackSkipped(bool isSkipped) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(_feedbackSkipped, isSkipped);
  }

  Future<bool> isFeedbackSkipped() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_feedbackSkipped) ?? false;
    });
  }

  Future<bool> resetFeedbackSkipped() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(_feedbackSkipped);
  }

  Future<void> setLastBackgroundedTime(int timestamp) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_lastBackgroundedTime, timestamp);
  }

  Future<int> getLastBackgroundedTime() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(_lastBackgroundedTime) ?? 1;
    });
  }

  Future<void> increaseFeedbackChargingDisplayCount() async {
    final SharedPreferences prefs = await _prefs;
    var count = await getFeedbackChargingDisplayCount();
    count += 1;
    prefs.setInt(_feedbackChargingDisplayCount, count);
  }

  Future<void> resetFeedbackChargingDisplayCount() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_feedbackChargingDisplayCount, 0);
  }

  Future<int> getFeedbackChargingDisplayCount() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(_feedbackChargingDisplayCount) ?? 0;
    });
  }

  Future<void> increaseFeedbackFuelingDisplayCount() async {
    final SharedPreferences prefs = await _prefs;
    var count = await getFeedbackFuelingDisplayCount();
    count += 1;
    prefs.setInt(_feedbackFuelingDisplayCount, count);
  }

  Future<void> resetFeedbackFuelingDisplayCount() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_feedbackFuelingDisplayCount, 0);
  }

  Future<int> getFeedbackFuelingDisplayCount() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(_feedbackFuelingDisplayCount) ?? 0;
    });
  }

  Future<void> increaseFeedbackChargingSuccessfulSessionCount() async {
    final SharedPreferences prefs = await _prefs;
    var count = await getFeedbackChargingSuccessfulSessionCount();
    count += 1;
    prefs.setInt(_feedbackChargingSuccessfulSessionCount, count);
  }

  Future<void> resetFeedbackChargingSuccessfulSessionCount() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_feedbackChargingSuccessfulSessionCount, 0);
  }

  Future<int> getFeedbackChargingSuccessfulSessionCount() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(_feedbackChargingSuccessfulSessionCount) ?? 0;
    });
  }

  Future<void> increaseFeedbackFuelingSuccessfulSessionCount() async {
    final SharedPreferences prefs = await _prefs;
    var count = await getFeedbackFuelingSuccessfulSessionCount();
    count += 1;
    prefs.setInt(_feedbackFuelingSuccessfulSessionCount, count);
  }

  Future<void> resetFeedbackFuelingSuccessfulSessionCount() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(_feedbackFuelingSuccessfulSessionCount, 0);
  }

  Future<int> getFeedbackFuelingSuccessfulSessionCount() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(_feedbackFuelingSuccessfulSessionCount) ?? 0;
    });
  }

  Future<void> cleanAll() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}
