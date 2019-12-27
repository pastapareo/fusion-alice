import 'package:http/http.dart' as http;

import '../models/account_balances_model.dart';
import 'account_info_remote_data_source.dart';

class FfdcAccountInfoDataSource implements AccountInfoRemoteDataSource {
  final http.Client client;

  FfdcAccountInfoDataSource({this.client});

  @override
  Future<AccountBalancesModel> getAccountBalances(String accountId) {
    // TODO: implement getAccountBalances
    return null;
  }
}
