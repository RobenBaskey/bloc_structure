import 'package:dartz/dartz.dart';

import '../../../../data/local_data_source/local_data_source.dart';
import '../../../../data/remote_data_source/remote_data_source.dart';

abstract class LoginRepository {
  Future<Either<Exception, String>> login(String email, password);
}


class LoginRepoImpl extends LoginRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  LoginRepoImpl({required this.remoteDataSource,required this.localDataSource});

  @override
  Future<Either<Exception, String>> login(String email, password) {
    // TODO: implement login
    throw UnimplementedError();
  }

}
