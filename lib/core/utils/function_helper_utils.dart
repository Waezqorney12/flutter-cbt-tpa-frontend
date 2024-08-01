import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../failure/failure_message.dart';

Future<Either<FailureMessage, T>> helperCall<T>({required Future<T> Function() apiCall}) async {
  try {
    final data = await apiCall();
    return right(data);
  } catch (e) {
    Log.loggerError(e);
    return left(FailureMessage("Failure error in repository: $e"));
  }
}
