import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entities/jwt_token.dart';

abstract class AuthorizationRepository {
  Future<Either<Failure, JwtToken>> generateToken();
}
