// ignore_for_file: avoid_print
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:stack_trace/stack_trace.dart';

enum LogLevel { info, debug, error, analytics }

class LoggerService {
  late Map<LogLevel, String> _logCharacters = <LogLevel, String>{};
  late Map<LogLevel, bool> _logLevels = <LogLevel, bool>{};

  void configure({required Map<LogLevel, bool> levels, required Map<LogLevel, String> characters}) {
    _logCharacters = characters;
    _logLevels = levels;
  }

  void info(Object message, {StackTrace? stack}) {
    _logConsole(LogLevel.info, message, stack);
  }

  void debug(Object message, {StackTrace? stack}) {
    _logConsole(LogLevel.debug, message, stack);
  }

  void error(Object message, {StackTrace? stack}) async {
    _logConsole(LogLevel.error, message, stack);
    FirebaseCrashlytics.instance.recordError(_prepareException(message), stack);
  }

  void analytics(Object message, {StackTrace? stack}) {
    _logConsole(LogLevel.analytics, message, stack);
  }

  void _logConsole(LogLevel level, Object message, StackTrace? stack) {
    if (_shouldLog(level)) {
      print(_prepareOutput(level, message, stack));
    }
  }

  Exception _prepareException(Object message) {
    return Exception(message);
  }

  bool _shouldLog(LogLevel level) {
    return _logLevels[level] ?? false;
  }

  String _getCharacter(LogLevel level) {
    return _logCharacters[level] ?? '📝';
  }

  String _prepareOutput(LogLevel level, Object message, StackTrace? stack) {
    var timeStamp = DateTime.now().toIso8601String();

    var header = '\n\n---- ' + _getCharacter(level) + ' ' + level.name + ' ----\n';
    var dateTime = '⏱ ' + timeStamp + '\n';
    var logMessage = '✉️ ' + message.toString() + '\n';
    var footer = '-------\n\n';

    if (stack != null) {
      var currentStack = Trace.from(stack);

      var logLocation = '📍 ';
      if (currentStack.frames.isNotEmpty) {
        var currentFrame = currentStack.frames[0];
        logLocation += currentFrame.location;
      } else {
        logLocation = 'Not traced';
      }

      logLocation += '\n';

      return header + dateTime + logMessage + logLocation + footer;
    }

    return header + dateTime + logMessage + footer;
  }
}
