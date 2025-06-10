import 'dart:async';

import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:food_for_family/common/viewmodels/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  // Actions
  Stream<bool> get onOpenMenu => _onOpenMenu.stream;
  final StreamController<bool> _onOpenMenu = StreamController();

  // Lifecycle
  StreamSubscription<FGBGType>? _lifecycleSubscription;

  // Error
  final bool _shouldShowFetchError = false;

  bool get shouldShowFetchError => _shouldShowFetchError;

  HomeViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    _initializeLifecycleSubscription();
  }

  void _initializeLifecycleSubscription() {
    _lifecycleSubscription = FGBGEvents.instance.stream.listen((event) {
      if (event == FGBGType.foreground) {
        notifyListeners();
      } else if (event == FGBGType.background) {
        notifyListeners();

        preferences.setLastBackgroundedTime(DateTime.now().millisecondsSinceEpoch);
      }
    });
  }

  @override
  void dispose() {
    _lifecycleSubscription?.cancel();
    super.dispose();
  }
}

extension HomeViewModelActionExtension on HomeViewModel {
  void openMenu() {
    _onOpenMenu.add(true);
  }
}
