import 'package:equatable/equatable.dart';

class JwtToken extends Equatable {
  String accessToken;

  JwtToken({this.accessToken});

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }

  @override
  List<Object> get props => [accessToken];
}
