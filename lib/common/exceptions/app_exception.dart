// ignore_for_file: prefer_typing_uninitialized_variables
class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_message';
  }
}
