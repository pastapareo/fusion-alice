import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'account_balance.dart';

class AccountBalanceResponse extends Equatable {
  String accountId;
  List<AccountBalance> balances;

  AccountBalanceResponse({
    @required this.accountId,
    @required this.balances,
  });

  Map<String, dynamic> toJson() {
    List balanceList = balances.map((balance) => balance.toJson()).toList();
    return {
      'accountId': accountId,
      'balances': balanceList,
    };
  }

  @override
  List<Object> get props => [accountId, balances];
}
