import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/account_balance_response.dart';
import '../../domain/repositories/account_info_repository.dart';
import '../datasources/account_info_local_data_source.dart';
import '../datasources/account_info_remote_data_source.dart';

typedef Future<AccountBalanceResponse> _GetAccountBalancesMethod();

class DataAccountInfoRepository implements AccountInfoRepository {
  final AccountInfoRemoteDataSource remoteDataSource;
  final AccountInfoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DataAccountInfoRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, AccountBalanceResponse>> getAccountBalances(String id) async {
    return await _getAccountBalances(() {
      return remoteDataSource.getAccountBalances(id);
    });
  }

  Future<Either<Failure, AccountBalanceResponse>> _getAccountBalances(
      _GetAccountBalancesMethod getAccountBalances) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAccountBalances = await getAccountBalances();
        localDataSource.cacheAccountBalances(remoteAccountBalances);
        return Right(remoteAccountBalances);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAccountBalances = await localDataSource.getLatestAccountBalances();
        return Right(localAccountBalances);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
