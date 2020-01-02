import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/usecases/usecase.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/jwt_token.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/repositories/authorization_repository.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/usecases/generate_token.dart';
import 'package:mockito/mockito.dart';

class MockAuthorizationRepository extends Mock implements AuthorizationRepository {}

void main() {
  GenerateToken usecase;
  MockAuthorizationRepository mockAuthorizationRepository;

  setUp(() {
    mockAuthorizationRepository = MockAuthorizationRepository();
    usecase = GenerateToken(repository: mockAuthorizationRepository);
  });

  final tJwtToken = JwtToken(accessToken: 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiA');

  test(
    'should get access token',
    () async {
      // arrange
      when(mockAuthorizationRepository.generateToken())
          .thenAnswer((_) async => Right(tJwtToken));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tJwtToken));
      verify(mockAuthorizationRepository.generateToken());
      verifyNoMoreInteractions(mockAuthorizationRepository);
    },
  );
}
