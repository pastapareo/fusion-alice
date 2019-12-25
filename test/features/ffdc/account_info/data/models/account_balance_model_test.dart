import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/account_info/data/models/account_balance_model.dart';
import 'package:fusion_alice/features/ffdc/account_info/data/models/monetary_amount_model.dart';

void main() {
  final tAmountModel = MonetaryAmountModel(amount: '73422.20', currency: 'USD');

  final tAccountBalanceModel = AccountBalanceModel(
    type: 'CLOSINGBOOKED',
    amount: tAmountModel,
    time: "2019-12-19T23:59:59+0530",
  );

  group('toJson', () {
    test(
      'should return a Json map with proper data',
      () async {
        // act
        final result = tAccountBalanceModel.toJson();
        // assert
        final expectedMap = {
          "balanceType": "CLOSINGBOOKED",
          "amount": {"amount": "73422.20", "currency": "USD"},
          "dateTime": "2019-12-19T23:59:59+0530"
        };
        expect(result, expectedMap);
      },
    );
  });
}
