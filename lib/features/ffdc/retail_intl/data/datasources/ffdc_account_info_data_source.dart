import 'dart:convert';

import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/jwt_token_model.dart';
import 'package:http/http.dart' as http;

import '../models/account_balances_model.dart';
import 'account_info_remote_data_source.dart';

class FfdcAccountInfoDataSource implements AccountInfoRemoteDataSource {
  final http.Client client;

  FfdcAccountInfoDataSource({this.client});

  @override
  Future<AccountBalancesModel> getAccountBalances(String accountId) async {
    final url =
        'https://api.fusionfabric.cloud/retail-banking/accounts/v1/accounts/$accountId/balances';

    final headers = Map<String, String>();
    headers['Authorization'] =
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJhenhYOVlMYzQ1LThIOThBQXJhanZmeldhLWIycFEtcnI2c0w2dFlZZHpNIn0.eyJqdGkiOiIzMzE4ZDY2Mi0yY2VmLTQ3MWUtOGYzZC0wYTVmODJlY2M1MmUiLCJleHAiOjE1NzgyOTk2MTAsIm5iZiI6MCwiaWF0IjoxNTc4Mjk2MDEwLCJpc3MiOiJodHRwczovL2FwaS5mdXNpb25mYWJyaWMuY2xvdWQvbG9naW4vdjEiLCJhdWQiOlsiYjJiLWFjY291bnQtdjEtYWMzNmVlMGEtYjYwMi00MjdjLWIyMzUtZTQxODljZTU2NWJmIiwicmV0YWlsLWJhbmtpbmctYWNjb3VudHMtdjEtNzQ4MGU4MjYtM2UzYy00MzIxLWE4MjAtNDY3YmU5YzUzMzEwIiwicmVmZXJlbnRpYWwtdjEtMzUzZjM5MzMtYzMwNS00ODk4LTg4ZDUtY2Q2Y2QxNjdmNzQ1IiwicmV0YWlsLWJhbmtpbmctYmlsbC1wYXltZW50cy12MS1hNTNiNTI3YS0zZmY5LTRkM2YtOWQ0YS0wM2M4YTJmMmUzMmIiLCJyZXRhaWwtYmFua2luZy1jdXN0b21lcnMtdjEtMzU4MTNlMWUtZTY4MC00NWQxLTkzYjUtNzYzYTJjZjI1NjIwIl0sInN1YiI6ImFjZjE1NGIzLTQxZTAtNDgxNC1iZWJkLTVkOTEwYmIwMGMzMSIsInR5cCI6IkJlYXJlciIsImF6cCI6ImFjZjE1NGIzLTQxZTAtNDgxNC1iZWJkLTVkOTEwYmIwMGMzMSIsImF1dGhfdGltZSI6MCwic2Vzc2lvbl9zdGF0ZSI6Ijk5MDgxNWQ2LWRjMmMtNDFhMS1iYmIyLWYwNmY2NGQ0NjUwNCIsImFjciI6IjEiLCJzY29wZSI6Im9wZW5pZCBiMmItYWNjb3VudC12MS1hYzM2ZWUwYS1iNjAyLTQyN2MtYjIzNS1lNDE4OWNlNTY1YmYgcmVmZXJlbnRpYWwtdjEtMzUzZjM5MzMtYzMwNS00ODk4LTg4ZDUtY2Q2Y2QxNjdmNzQ1IHJldGFpbC1iYW5raW5nLWFjY291bnRzLXYxLTc0ODBlODI2LTNlM2MtNDMyMS1hODIwLTQ2N2JlOWM1MzMxMCByZXRhaWwtYmFua2luZy1jdXN0b21lcnMtdjEtMzU4MTNlMWUtZTY4MC00NWQxLTkzYjUtNzYzYTJjZjI1NjIwIHJldGFpbC1iYW5raW5nLWJpbGwtcGF5bWVudHMtdjEtYTUzYjUyN2EtM2ZmOS00ZDNmLTlkNGEtMDNjOGEyZjJlMzJiIiwiYXBwIjoiYWNmMTU0YjMtNDFlMC00ODE0LWJlYmQtNWQ5MTBiYjAwYzMxIiwiaW50SXBXaGl0ZWxpc3QiOiIiLCJpcHdoaXRlbGlzdCI6IiIsInRlbmFudCI6InNhbmRib3giLCJ1c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1hY2YxNTRiMy00MWUwLTQ4MTQtYmViZC01ZDkxMGJiMDBjMzEifQ.mE9W2xlyuxFwl2ojzMhke4X4kuEK2nmuDoInfE9r_Gzef-NnRs8jgxiLCssjOGUQrE9YQIMM8eKXoTgDYyyQY7JuQ3NahGXuQvvv6JSweEoP3O1AIemCKeHX4h8YCDG74lSfAeLQG9NXMOvSAfNL2XVuz3_4svnHXR8kWzKucOpmlB36uu1oD5Mu-c0wJ6ZslQCm8fJD8JItVNjD1hN2js79eXTgz1Zur6CD8DnaZ_s7W8p-zinF_I9jXPMnyqP_L_BM30ULRgl7kqfvQhlVofzDc93neBfPtmuYCGLIkq3YH38CrxaNLoS15vxtTwEXXqx1ugBM2kce6kkSZkJf9g';
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    headers['X-Request-ID'] = '6d1a09f9-eeb0-4c17-a21a-b82b28e117f7';

    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return AccountBalancesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
