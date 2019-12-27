import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'monetary_amount.dart';

class AccountBalance extends Equatable {
  String type;
  MonetaryAmount amount;
  String time;

  AccountBalance({
    @required this.type,
    @required this.amount,
    this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'balanceType': type,
      'amount': amount.toJson(),
      'dateTime': time,
    };
  }

  @override
  List<Object> get props => [type, amount, time];
}
