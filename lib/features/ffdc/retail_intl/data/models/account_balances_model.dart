import 'package:meta/meta.dart';

import '../../domain/entities/account_balance_response.dart';
import 'account_balance_model.dart';

class AccountBalancesModel extends AccountBalanceResponse {
  AccountBalancesModel({
    @required String accountId,
    @required List<AccountBalanceModel> balances,
  }) : super(accountId: accountId, balances: balances);

  factory AccountBalancesModel.fromJson(Map<String, dynamic> json) {
    var list = json['balances'] as List;
    List<AccountBalanceModel> balanceList =
        list.map((i) => AccountBalanceModel.fromJson(i)).toList();

    return new AccountBalancesModel(
      accountId: json['accountId'],
      balances: balanceList,
    );
  }

  Map<String, dynamic> toJson() {
    List balanceList = balances.map((balance) => balance.toJson()).toList();
    return {
      'accountId': accountId,
      'balances': balanceList,
    };
  }
}
