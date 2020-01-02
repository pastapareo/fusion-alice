import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  @override
  AccountInfoState get initialState => Empty();

  @override
  Stream<AccountInfoState> mapEventToState(
    AccountInfoEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
