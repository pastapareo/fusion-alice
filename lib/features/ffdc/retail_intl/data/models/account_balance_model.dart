import 'package:meta/meta.dart';

import '../../domain/entities/account_balance.dart';
import 'monetary_amount_model.dart';

class AccountBalanceModel extends AccountBalance {
  AccountBalanceModel({
    @required String type,
    @required MonetaryAmountModel amount,
    String time,
  }) : super(type: type, amount: amount, time: time);

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) {
    return new AccountBalanceModel(
      type: json['balanceType'],
      amount: MonetaryAmountModel.fromJson(json['amount']),
      time: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balanceType': type,
      'amount': amount.toJson(),
      'dateTime': time,
    };
  }
}
