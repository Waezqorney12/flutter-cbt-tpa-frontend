import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';

typedef FutureEither<T> = Future<Either<FailureMessage,T>>;
typedef PresentEither<T> = Either<FailureMessage, T>; 