import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MonetaryAmount extends Equatable {
  String amount;
  String currency;

  MonetaryAmount({
    @required this.amount,
    @required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  List<Object> get props => [amount, currency];
}
