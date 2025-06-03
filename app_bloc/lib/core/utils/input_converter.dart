import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';


class InputConverter {
  Either<Failure, int> stringToInteger(String str) {
    try {
      final number = int.parse(str);
      if (number < 0) throw FormatException();
      return Right(number);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
