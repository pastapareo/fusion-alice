import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';

abstract class AuthorizationDataSource {
  /// Calls the authorization endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<JwtTokenModel> generateToken();
}
