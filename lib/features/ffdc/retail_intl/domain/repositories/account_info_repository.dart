import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entities/account_balance_response.dart';

abstract class AccountInfoRepository {
  Future<Either<Failure, AccountBalanceResponse>> getAccountBalances(String id);
}
