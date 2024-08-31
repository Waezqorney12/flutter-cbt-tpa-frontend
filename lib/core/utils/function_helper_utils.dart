import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';

import '../message/failure_message.dart';

Future<Either<FailureMessage, T>> helperCall<T>({required Future<T> Function() apiCall}) async {
  try {
    final data = await apiCall();
    return right(data);
  } catch (e) {
    Log.loggerError("Failure error in repository: $e");
    return left(FailureMessage("Failure error in repository: $e"));
  }
}

FutureEither<T> helperCallWithException<T>({
  required Future<T> Function() firstConnection,
  required Future<T> Function() secondConnection,
}) async {
  try {
    final firstData = await firstConnection();
    final secondData = await secondConnection();
    if (firstData != null) {
      return right(firstData);
    } else if (secondData != null) {
      return right(secondData);
    } else {
      return left(FailureMessage('Both connections returned null'));
    }
  } catch (e) {
    Log.loggerError("Failure error in repository: $e");
    return left(FailureMessage('Catch error in repository: $e'));
  }
}
