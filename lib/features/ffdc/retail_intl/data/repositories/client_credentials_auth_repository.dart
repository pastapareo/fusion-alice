import 'package:dartz/dartz.dart';
import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/core/error/failures.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/authorization_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/jwt_token.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/repositories/authorization_repository.dart';

class ClientCredentialsAuthRepository implements AuthorizationRepository {
  final AuthorizationDataSource authorizationDataSource;

  ClientCredentialsAuthRepository({this.authorizationDataSource});

  @override
  Future<Either<Failure, JwtToken>> generateToken() async {
    try {
      final token = await authorizationDataSource.generateToken();
      return Right(token);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
