import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}
