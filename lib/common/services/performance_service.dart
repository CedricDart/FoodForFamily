import 'package:firebase_performance/firebase_performance.dart';
import 'package:food_for_family/common/services/base/base_service.dart';

class PerformanceService extends BaseService {
  final FirebasePerformance _performance;

  static PerformanceService? _instance;

  static Trace? refreshTrace;
  static Trace? refreshFlowTrace;
  static Trace? loadStationsTrace;

  static Future<PerformanceService> getInstance() async {
    _instance ??= PerformanceService(
      performance: FirebasePerformance.instance,
    );

    return _instance!;
  }

  PerformanceService({required FirebasePerformance performance}) : _performance = performance;

  Future<void> initialiseTraces() async {
    refreshTrace = _performance.newTrace("refresh_token");
    refreshFlowTrace = _performance.newTrace("refresh_token_flow");
    loadStationsTrace = _performance.newTrace("load_stations");
  }

  Future<void> startTrace(Trace? trace) async {
    await trace?.start();
  }

  Future<void> stopTrace(Trace? trace) async {
    await trace?.stop();
  }

  Future<Trace> addTrace(String traceName) async {
    return _performance.newTrace(traceName);
  }
}
