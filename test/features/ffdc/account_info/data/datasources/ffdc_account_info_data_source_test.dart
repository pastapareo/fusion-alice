import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/ffdc_account_info_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  FfdcAccountInfoDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = FfdcAccountInfoDataSource(client: mockHttpClient);
  });

  group('getAccountBalances', () {
    final tAccountId = '01010OA00P200';

    test(
      '''should perform a GET request on the account balances endpoint 
        with application/json as header''',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response(fixture('account_balances.json'), 200));
        // act
        dataSource.getAccountBalances(tAccountId);
        // assert
        verify(mockHttpClient.get(
          'https://api.fusionfabric.cloud/retail-banking/accounts/v1/accounts/$tAccountId/balances',
          headers: {
            "Authorization": "Bearer ",
            "Accept": "application/json",
            "Content-type": "application/json",
            "X-Request-ID": "6d1a09f9-eeb0-4c17-a21a-b82b28e117f7"
          },
        ));
      },
    );
  });
}
