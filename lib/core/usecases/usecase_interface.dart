import 'package:fpdart/fpdart.dart';

import '../failure/failure_message.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<FailureMessage, T>> call(Params params);
}

class NoParams {}
