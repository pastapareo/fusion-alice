import '../models/account_balances_model.dart';

abstract class AccountInfoRemoteDataSource {
  /// Calls the Retail International Get Account Balances endpoint.
  ///
  /// Throws a [ServerException] on all error codes.
  Future<AccountBalancesModel> getAccountBalances(String accountId);
}
