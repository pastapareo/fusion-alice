import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/error/failures.dart';
import 'package:fusion_alice/core/util/constants.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/account_balance.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/account_balance_response.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/monetary_amount.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/usecases/get_account_balances.dart'
    as accountInfo;
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetAccountBalances extends Mock implements accountInfo.GetAccountBalances {}

void main() {
  AccountInfoBloc bloc;
  MockGetAccountBalances mockGetAccountBalances;

  setUp(() {
    mockGetAccountBalances = MockGetAccountBalances();
    bloc = AccountInfoBloc(getAccountBalances: mockGetAccountBalances);
  });

  test(
    'initialState should be Empty',
    () async {
      // assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetAccountBalances', () {
    final tAccountId = '01010OA00P200';

    final tBalance = AccountBalance(
        type: 'CA',
        amount: MonetaryAmount(
          amount: '1,000',
          currency: 'GBP',
        ),
        time: '10Dec');

    final tAccountBalanceResponse = AccountBalanceResponse(
      accountId: tAccountId,
      balances: [tBalance],
    );

    test(
      'should get data from the GetAccountBalances use case',
      () async {
        // arrange
        when(mockGetAccountBalances(any))
            .thenAnswer((_) async => Right(tAccountBalanceResponse));
        // act
        bloc.add(GetAccountBalances(tAccountId));
        await untilCalled(mockGetAccountBalances(any));
        // assert
        verify(mockGetAccountBalances(accountInfo.Params(accountId: tAccountId)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten succesfully',
      () async {
        // arrange
        when(mockGetAccountBalances(any))
            .thenAnswer((_) async => Right(tAccountBalanceResponse));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(balances: tAccountBalanceResponse),
        ];
        expectLater(bloc, emitsInAnyOrder(expected));
        // act
        bloc.add(GetAccountBalances(tAccountId));
      },
    );

    test(
      'should emit [Loading, Error] when getting data on the server fails',
      () async {
        // arrange
        when(mockGetAccountBalances(any)).thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: Messages.serverFailureMessage),
        ];
        expectLater(bloc, emitsInAnyOrder(expected));
        // act
        bloc.add(GetAccountBalances(tAccountId));
      },
    );

    test(
      'should emit [Loading, Error] when getting data in cache fails',
      () async {
        // arrange
        when(mockGetAccountBalances(any)).thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: Messages.cacheFailureMessage),
        ];
        expectLater(bloc, emitsInAnyOrder(expected));
        // act
        bloc.add(GetAccountBalances(tAccountId));
      },
    );
  });
}
