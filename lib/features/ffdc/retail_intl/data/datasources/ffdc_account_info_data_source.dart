import 'dart:convert';

import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';
import 'package:http/http.dart' as http;

import '../models/account_balances_model.dart';
import 'account_info_remote_data_source.dart';

class FfdcAccountInfoDataSource implements AccountInfoRemoteDataSource {
  final http.Client client;

  FfdcAccountInfoDataSource({this.client});

  @override
  Future<AccountBalancesModel> getAccountBalances(String accountId) async {
    final url =
        'https://api.fusionfabric.cloud/retail-banking/accounts/v1/accounts/$accountId/balances';

    final headers = Map<String, String>();
    headers['Authorization'] = 'token';
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    headers['X-Request-ID'] = '6d1a09f9-eeb0-4c17-a21a-b82b28e117f7';

    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return AccountBalancesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
