import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppIcons {
  // Map
  static const String datsAvailable = 'assets/images/map-icon-dats24-available.svg';
  static const String datsAvailableSelected = 'assets/images/map-icon-dats24-available-selected.svg';
  static const String datsUnavailable = 'assets/images/map-icon-dats24-unavailable.svg';
  static const String datsUnavailableSelected = 'assets/images/map-icon-dats24-unavailable-selected.svg';

  static const String otherAvailable = 'assets/images/map-icon-other-available.svg';
  static const String otherAvailableSelected = 'assets/images/map-icon-other-available-selected.svg';
  static const String otherUnavailable = 'assets/images/map-icon-other-unavailable.svg';
  static const String otherUnavailableSelected = 'assets/images/map-icon-other-unavailable-selected.svg';

  // List
  static const String stationDatsIcon = 'assets/images/list-icon-station-dats.png';

  // Filter
  static const String sliderHandlerIcon = 'assets/images/slider-handler.png';

  // Connectors
  static const String connectorCCS1Icon = 'assets/images/connector-icon-ccs1.png';
  static const String connectorCCS2Icon = 'assets/images/connector-icon-ccs2.png';
  static const String connectorCHAdeMOIcon = 'assets/images/connector-icon-chademo.png';
  static const String connectorSchukoBEFRIcon = 'assets/images/connector-icon-schuko-be-fr.png';
  static const String connectorSchukoEUROIcon = 'assets/images/connector-icon-schuko-euro.png';
  static const String connectorSchukoNLDEIcon = 'assets/images/connector-icon-schuko-nl-de.png';
  static const String connectorType1Icon = 'assets/images/connector-icon-type1.png';
  static const String connectorType2Icon = 'assets/images/connector-icon-type2.png';
  static const String connectorType3Icon = 'assets/images/connector-icon-type3.png';

  static const String filterIcon = 'assets/images/icon-filter.png';
  static const String chargingIcon = 'assets/images/icon-charging.svg';

  // Transaction
  static const String transactionChargingOnProgress = 'assets/images/icon-car-charging.svg';
  static const String transactionChargingComplete = 'assets/images/icon-car-charging-complete.svg';
  static const String transactionChargingFailed = 'assets/images/icon-car-charging-failed.svg';

  static const String transactionChargingCompleteSmall = 'assets/images/icon-charging-success-small.svg';
  static const String transactionChargingFailedSmall = 'assets/images/icon-charging-failed-small.svg';

  static const String transactionFuelingOnProgress = 'assets/images/icon-fueling-in-progress.svg';

  static const String transactionFuelingFailedSmall = 'assets/images/icon-fueling-failed.svg';
  static const String transactionFuelingCompleteSmall = 'assets/images/icon-fueling-complete.svg';

  static const String transactionFuelingComplete = 'assets/images/icon-car-fueling-complete.svg';
  static const String transactionFuelingFailed = 'assets/images/icon-car-fueling-failed.svg';

  // Nagging
  static const String digitalCardsIcon = 'assets/images/icon-digital-cards.png';
  static const String userSettingsIcon = 'assets/images/icon-user-settings.png';

  // Camera
  static const String cameraZoomIn = 'assets/images/icon-camera-zoom-in.png';
}

class MapMarkers {
  static late BitmapDescriptor datsAvailable;
  static late BitmapDescriptor datsAvailableSelected;
  static late BitmapDescriptor datsUnavailable;
  static late BitmapDescriptor datsUnavailableSelected;

  static late BitmapDescriptor otherAvailable;
  static late BitmapDescriptor otherAvailableSelected;
  static late BitmapDescriptor otherUnavailable;
  static late BitmapDescriptor otherUnavailableSelected;
}
