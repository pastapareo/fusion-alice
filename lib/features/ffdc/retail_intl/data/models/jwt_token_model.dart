import 'package:meta/meta.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/jwt_token.dart';

class JwtTokenModel extends JwtToken {
  JwtTokenModel({
    @required String accessToken,
  }) : super(accessToken: accessToken);

  factory JwtTokenModel.fromJson(Map<String, dynamic> json) {
    return new JwtTokenModel(
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
