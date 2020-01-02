import 'dart:convert';

import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/authorization_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';
import 'package:http/http.dart' as http;

class ClientCredentialsAuthDataSource implements AuthorizationDataSource {
  final http.Client client;

  ClientCredentialsAuthDataSource({this.client});

  @override
  Future<JwtTokenModel> generateToken() async {
    final authUrl = 'https://api.fusionfabric.cloud/login/v1/sandbox/oidc/token';

    final requestBody = Map<String, dynamic>();
    requestBody['client_id'] = 'a215a8a0-7c04-42ed-9d0c-503240942531';
    requestBody['client_secret'] = 'bdb5ce2c-6ab6-4518-8057-c57da0380d64';
    requestBody['grant_type'] = 'client_credentials';

    final response = await client.post(
      authUrl,
      body: requestBody,
    );

    return JwtTokenModel.fromJson(json.decode(response.body));
  }
}
