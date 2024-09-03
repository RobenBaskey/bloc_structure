import 'package:dartz/dartz.dart';

import '../../../../data/local_data_source/local_data_source.dart';
import '../../../../data/remote_data_source/remote_data_source.dart';

abstract class SplashRepository{
  Future<Either<Exception,String>> checkLogin();
}

class SplashRepositoryImpl extends SplashRepository{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  SplashRepositoryImpl({required this.remoteDataSource,required this.localDataSource});

  @override
  Future<Either<Exception, String>> checkLogin() {
    // TODO: implement checkLogin
    throw UnimplementedError();
  }

}