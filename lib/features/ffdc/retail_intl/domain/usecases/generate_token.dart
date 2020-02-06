import 'package:dartz/dartz.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/repositories/authorization_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/jwt_token.dart';

class GenerateToken extends UseCase<JwtToken, NoParams> {
  final AuthorizationRepository repository;

  GenerateToken({this.repository});

  @override
  Future<Either<Failure, JwtToken>> call(NoParams params) async {
    return await repository.generateToken();
  }
}
