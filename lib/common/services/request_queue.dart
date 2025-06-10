import 'package:food_for_family/common/services/base/base_service.dart';
import 'package:queue/queue.dart';

class RequestQueue extends BaseService {
  static final Queue _queue = Queue(delay: const Duration(milliseconds: 10));

  static Queue get queue => _queue;
}
