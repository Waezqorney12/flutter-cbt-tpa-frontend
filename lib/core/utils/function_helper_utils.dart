import 'package:fpdart/fpdart.dart';

import '../failure/failure_message.dart';

Future<Either<FailureMessage, T>> helperCall<T>({required Future<T> Function() apiCall}) async {
  try {
    final data = await apiCall();
    return right(data);
  } catch (e) {
    return left(FailureMessage("Failure error in repository: $e"));
  }
}
