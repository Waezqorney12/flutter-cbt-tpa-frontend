import 'package:logger/logger.dart';

class Log {
  static final Logger logger = Logger();
  static final loggerDebug = logger.d;
  static final loggerError = logger.e;
  static final loggerFatal = logger.f;
  static final loggerInformation = logger.i;
  static final loggerTrace = logger.t;
  static final loggerWarning = logger.w;
}
