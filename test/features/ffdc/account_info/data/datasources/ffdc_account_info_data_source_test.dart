import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/ffdc_account_info_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/account_balances_model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  FfdcAccountInfoDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = FfdcAccountInfoDataSource(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('account_balances.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getAccountBalances', () {
    final tAccountId = '01010OA00P200';
    final tAccountBalancesModel =
        AccountBalancesModel.fromJson(json.decode(fixture('account_balances.json')));

    final tUrl =
        'https://api.fusionfabric.cloud/retail-banking/accounts/v1/accounts/$tAccountId/balances';

    final tHeaders = Map<String, String>();
    tHeaders['Authorization'] = 'token';
    tHeaders['Accept'] = 'application/json';
    tHeaders['Content-type'] = 'application/json';
    tHeaders['X-Request-ID'] = '6d1a09f9-eeb0-4c17-a21a-b82b28e117f7';

    test(
      '''should perform a GET request on the account balances endpoint 
        with application/json as header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        dataSource.getAccountBalances(tAccountId);
        // assert
        verify(mockHttpClient.get(tUrl, headers: tHeaders));
      },
    );

    test(
      'should return AccountBalancesResponse when the response code is 200',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        final result = await dataSource.getAccountBalances(tAccountId);
        // assert
        expect(result, equals(tAccountBalancesModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        // call: getAccountBalances function
        final call = dataSource.getAccountBalances;
        // assert
        expect(() => call(tAccountId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
