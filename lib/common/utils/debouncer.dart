import 'dart:async';

import 'package:flutter/material.dart';

class DeBouncer {
  final int milliseconds;
  Timer? _timer;

  DeBouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
