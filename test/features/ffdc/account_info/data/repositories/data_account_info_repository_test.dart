import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_alice/core/error/exception.dart';
import 'package:fusion_alice/core/error/failures.dart';
import 'package:fusion_alice/core/network/network_info.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/account_info_local_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/datasources/account_info_remote_data_source.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/account_balance_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/account_balances_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/models/monetary_amount_model.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/data/repositories/data_account_info_repository.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/account_balance_response.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements AccountInfoRemoteDataSource {}

class MockLocalDataSource extends Mock implements AccountInfoLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  DataAccountInfoRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DataAccountInfoRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAccountBalances', () {
    // Data
    final tAccountId = '01010OA00P200';

    final tAmountModel = MonetaryAmountModel(
      amount: '73422.20',
      currency: 'USD',
    );

    final tAccountBalanceModel = AccountBalanceModel(
      type: 'CLOSINGBOOKED',
      amount: tAmountModel,
      time: "2019-12-19T23:59:59+0530",
    );

    final tAccountBalancesModel = AccountBalancesModel(
      accountId: '01010OA00P200',
      balances: [tAccountBalanceModel],
    );

    final AccountBalanceResponse tAccountBalanceResponse = tAccountBalancesModel;

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getAccountBalances(tAccountId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAccountBalances(tAccountId))
            .thenAnswer((_) async => tAccountBalancesModel);
        // act
        final result = await repository.getAccountBalances(tAccountId);
        // assert
        verify(mockRemoteDataSource.getAccountBalances(tAccountId));
        expect(result, equals(Right(tAccountBalanceResponse)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAccountBalances(tAccountId))
            .thenAnswer((_) async => tAccountBalancesModel);
        // act
        await repository.getAccountBalances(tAccountId);
        // assert
        verify(mockRemoteDataSource.getAccountBalances(tAccountId));
        verify(mockLocalDataSource.cacheAccountBalances(tAccountBalancesModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAccountBalances(tAccountId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getAccountBalances(tAccountId);
        // assert
        verify(mockRemoteDataSource.getAccountBalances(tAccountId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLatestAccountBalances())
            .thenAnswer((_) async => tAccountBalancesModel);
        // act
        final result = await repository.getAccountBalances(tAccountId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLatestAccountBalances());
        expect(result, equals(Right(tAccountBalanceResponse)));
      });

      test('should return CacheFailure when there is no cached data present', () async {
        // arrange
        when(mockLocalDataSource.getLatestAccountBalances()).thenThrow(CacheException());
        // act
        final result = await repository.getAccountBalances(tAccountId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLatestAccountBalances());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
