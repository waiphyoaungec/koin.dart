
import 'package:koin/src/core/error/exceptions.dart';

void error(String msg) => Error.error(msg);

class Error {
  static void error(String msg) {
    throw IllegalStateException(msg);
  }
}

class Intrinsics {
  static void checkParameterIsNotNull(dynamic value, String name) {
    if (value == null) {
      throw IllegalStateException('$name cannot be null.');
    }
  }
}