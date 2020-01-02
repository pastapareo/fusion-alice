import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/client_credentials_auth_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ClientCredentialsAuthDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ClientCredentialsAuthDataSource(client: mockHttpClient);
  });

  group('generateToken', () {
    final tAuthUrl = 'https://api.fusionfabric.cloud/login/v1/sandbox/oidc/token';

    final tRequestBody = Map<String, dynamic>();
    tRequestBody['client_id'] = 'a215a8a0-7c04-42ed-9d0c-503240942531';
    tRequestBody['client_secret'] = 'bdb5ce2c-6ab6-4518-8057-c57da0380d64';
    tRequestBody['grant_type'] = 'client_credentials';

    test('should perform a POST request on the authorization endpoint', () async {
      // arrange
      when(mockHttpClient.post(any, body: tRequestBody))
          .thenAnswer((_) async => http.Response(
                fixture('jwt_token.json'),
                200,
              ));
      // act
      dataSource.generateToken();
      // assert
      verify(mockHttpClient.post(tAuthUrl, body: tRequestBody));
    });

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // TODO Implement this test
        // arrange

        // act

        // assert
      },
    );
  });
}
