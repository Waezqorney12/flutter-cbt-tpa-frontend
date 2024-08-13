import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../failure/failure_message.dart';

Future<Either<FailureMessage, T>> helperCall<T>({required Future<T> Function() apiCall}) async {
  try {
    final data = await apiCall();
    return right(data);
  } catch (e) {
    Log.loggerError("Failure error in repository: $e");
    return left(FailureMessage("Failure error in repository: $e"));
  }
}

Future<Either<X, T>> helperCallWithException<X, T>({
  required Future<T> Function() apiCall,
  required Future<X> Function() networkCall,
}) async {
  try {
    final data = await apiCall();
    return right(data);
  } catch (e) {
    final data = await networkCall();
    return left(data);
  }
}
