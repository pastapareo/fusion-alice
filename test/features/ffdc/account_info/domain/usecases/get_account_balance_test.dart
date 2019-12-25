import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/entities/account_balance.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/entities/account_balance_response.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/entities/monetary_amount.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/repositories/account_info_repository.dart';
import 'package:fusion_alice/features/ffdc/account_info/domain/usecases/get_account_balance.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountInfoRepository {}

void main() {
  GetAccountBalance usecase;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    usecase = GetAccountBalance(mockAccountRepository);
  });

  final tAccountId = '0543123467001';

  final tBalance = AccountBalance(
      type: 'CA',
      amount: MonetaryAmount(
        amount: '1,000',
        currency: 'GBP',
      ),
      time: '10Dec');

  final tAccountBalanceResponse = AccountBalanceResponse(
    accountId: '0543123467001',
    balances: [tBalance],
  );

  test(
    'shoud get balance for the account number',
    () async {
      // arange
      when(mockAccountRepository.getAccountBalances(any))
          .thenAnswer((_) async => Right(tAccountBalanceResponse));

      // act
      final result = await usecase(Params(accountId: tAccountId));

      // assert
      expect(result, Right(tAccountBalanceResponse));
      verify(mockAccountRepository.getAccountBalances(tAccountId));
      verifyNoMoreInteractions(mockAccountRepository);
    },
  );
}
