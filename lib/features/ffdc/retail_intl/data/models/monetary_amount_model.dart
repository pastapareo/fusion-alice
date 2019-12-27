import 'package:meta/meta.dart';

import '../../domain/entities/monetary_amount.dart';

class MonetaryAmountModel extends MonetaryAmount {
  MonetaryAmountModel({
    @required String amount,
    @required String currency,
  }) : super(amount: amount, currency: currency);

  factory MonetaryAmountModel.fromJson(Map<String, dynamic> json) {
    return MonetaryAmountModel(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
