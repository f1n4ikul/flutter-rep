import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../../../domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Right(users);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
