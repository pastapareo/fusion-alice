import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/util/constants.dart';
import '../models/account_balances_model.dart';
import 'account_info_local_data_source.dart';

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
