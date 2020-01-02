import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/core/error/failures.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/authorization_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/repositories/client_credentials_auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthorizationDataSource extends Mock implements AuthorizationDataSource {}

void main() {
  ClientCredentialsAuthRepository repository;
  MockAuthorizationDataSource mockAuthorizationDataSource;

  setUp(() {
    mockAuthorizationDataSource = MockAuthorizationDataSource();
    repository = ClientCredentialsAuthRepository(
      authorizationDataSource: mockAuthorizationDataSource,
    );
  });

  group('generateToken', () {
    final tJwtTokenModel = JwtTokenModel(accessToken: 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiA');

    test('should return a token when the call to authorization data source is succesful',
        () async {
      // arrange
      when(mockAuthorizationDataSource.generateToken())
          .thenAnswer((_) async => tJwtTokenModel);
      // act
      final result = await repository.generateToken();
      // assert
      verify(mockAuthorizationDataSource.generateToken());
      expect(result, equals(Right(tJwtTokenModel)));
    });

    test(
        'should return server failure when the call to authorization data source is unsuccesfull',
        () async {
      // arrange
      when(mockAuthorizationDataSource.generateToken()).thenThrow(ServerException());
      // act
      final result = await repository.generateToken();
      // assert
      verify(mockAuthorizationDataSource.generateToken());
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
