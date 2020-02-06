import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/core/util/constants.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/shared_pref_account_info_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/account_balance_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/account_balances_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/monetary_amount_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SharedPreferencesAccountInfoDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        SharedPreferencesAccountInfoDataSource(sharedPreferences: mockSharedPreferences);
  });

  group('getLatestAccountBalances', () {
    final tAccountBalances =
        AccountBalancesModel.fromJson(json.decode(fixture('account_balances.json')));
    test(
      'should return AccountBalances from SharedPreferences when there is one on the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('account_balances.json'));
        // act
        final result = await dataSource.getLatestAccountBalances();
        // assert
        verify(mockSharedPreferences.getString(Constants.cachedAccountBalance));
        expect(result, equals(tAccountBalances));
      },
    );

    test(
      'should throw CacheException when there is no cached data',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        // call: getLatestAccountBalances function
        final call = dataSource.getLatestAccountBalances;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheAccountBalances', () {
    final tAmountModel = MonetaryAmountModel(amount: '73422.20', currency: 'USD');

    final tAccountBalanceModel = AccountBalanceModel(
      type: 'CLOSINGBOOKED',
      amount: tAmountModel,
      time: "2019-12-19T23:59:59+0530",
    );

    final tAccountBalancesModel = AccountBalancesModel(
      accountId: '01010OA00P200',
      balances: [tAccountBalanceModel],
    );
    test('should call SharedPreferences to cache data', () async {
      // act
      dataSource.cacheAccountBalances(tAccountBalancesModel);
      // assert
      final expectedJsonString = json.encode(tAccountBalancesModel.toJson());
      verify(mockSharedPreferences.setString(
        Constants.cachedAccountBalance,
        expectedJsonString,
      ));
    });
  });
}
