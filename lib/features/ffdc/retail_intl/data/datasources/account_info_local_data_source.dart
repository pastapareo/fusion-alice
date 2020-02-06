import '../models/account_balances_model.dart';

abstract class AccountInfoLocalDataSource {
  /// Gets the cached [AccountBalancesModel] which we got the last time the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<AccountBalancesModel> getLatestAccountBalances();

  Future<void> cacheAccountBalances(AccountBalancesModel accountBalancesToCache);
}
