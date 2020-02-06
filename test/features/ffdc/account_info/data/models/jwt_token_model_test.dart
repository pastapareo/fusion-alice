import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final tJwtTokenModel = JwtTokenModel(accessToken: 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiA');

  group('fromJson', () {
    test(
      'should return a valid model from a string',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('jwt_token.json'));
        // act
        final result = JwtTokenModel.fromJson(jsonMap);
        // assert
        expect(result, tJwtTokenModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map with proper data',
      () async {
        // act
        final result = tJwtTokenModel.toJson();
        // assert
        final expectedMap = {"access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiA"};
        expect(result, expectedMap);
      },
    );
  });
}
