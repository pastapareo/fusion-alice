import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/account_balance_response.dart';
import '../repositories/account_info_repository.dart';

class GetAccountBalance extends UseCase<AccountBalanceResponse, Params> {
  final AccountInfoRepository repository;

  GetAccountBalance(this.repository);

  @override
  Future<Either<Failure, AccountBalanceResponse>> call(Params params) async {
    return await repository.getAccountBalances(params.accountId);
  }
}

class Params extends Equatable {
  final String accountId;

  Params({@required this.accountId});

  @override
  List<Object> get props => [accountId];
}
