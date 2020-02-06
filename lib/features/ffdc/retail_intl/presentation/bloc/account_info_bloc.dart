import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fusion_alice/core/error/failures.dart';
import 'package:fusion_alice/core/util/constants.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/usecases/get_account_balances.dart'
    as accountInfo;
import 'package:meta/meta.dart';

import './bloc.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  final accountInfo.GetAccountBalances getAccountBalances;

  AccountInfoBloc({@required this.getAccountBalances})
      : assert(getAccountBalances != null);

  @override
  AccountInfoState get initialState => Empty();

  @override
  Stream<AccountInfoState> mapEventToState(
    AccountInfoEvent event,
  ) async* {
    if (event is GetAccountBalances) {
      yield Loading();
      final result =
          await getAccountBalances(accountInfo.Params(accountId: event.accountId));
      yield result.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (accountBalances) => Loaded(balances: accountBalances),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Messages.serverFailureMessage;
      case CacheFailure:
        return Messages.cacheFailureMessage;
      default:
        return Messages.unexpectedError;
    }
  }
}
