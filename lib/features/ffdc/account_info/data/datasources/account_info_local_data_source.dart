import 'dart:convert';

import 'package:fusion_alice/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/account_balances_model.dart';

abstract class AccountInfoLocalDataSource {
  /// Gets the cached [AccountBalancesModel] which we got the last time the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<AccountBalancesModel> getLatestAccountBalances();

  Future<void> cacheAccountBalances(AccountBalancesModel accountBalancesToCache);
}

class SharedPreferencesAccountInfoDataSource implements AccountInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesAccountInfoDataSource({@required this.sharedPreferences});

  @override
  Future<void> cacheAccountBalances(AccountBalancesModel accountBalancesToCache) {
    return sharedPreferences.setString(
      Constants.cachedAccountBalance,
      json.encode(accountBalancesToCache.toJson()),
    );
  }

  @override
  Future<AccountBalancesModel> getLatestAccountBalances() {
    final jsonString = sharedPreferences.getString(Constants.cachedAccountBalance);
    if (jsonString != null) {
      return Future.value(AccountBalancesModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
