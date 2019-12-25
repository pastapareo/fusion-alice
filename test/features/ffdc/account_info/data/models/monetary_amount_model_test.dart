import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/account_info/data/models/monetary_amount_model.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/entities/monetary_amount.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final tAmountModel = MonetaryAmountModel(amount: '73422.20', currency: 'USD');

  test(
    'should be a subclass of MonetaryAmount entity',
    () async {
      // assert
      expect(tAmountModel, isA<MonetaryAmount>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('monetary_amount.json'));
        // act
        final result = MonetaryAmountModel.fromJson(jsonMap);
        // assert
        expect(result, tAmountModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map with proper data',
      () async {
        // act
        final result = tAmountModel.toJson();
        // assert
        final expectedMap = {
          "amount": "73422.20",
          "currency": "USD",
        };
        expect(result, expectedMap);
      },
    );
  });
}
