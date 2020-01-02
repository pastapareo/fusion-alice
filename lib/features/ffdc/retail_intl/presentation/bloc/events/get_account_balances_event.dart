import '../bloc.dart';

class GetAccountBalances extends AccountInfoEvent {
  final String accountId;

  GetAccountBalances(this.accountId);

  @override
  List<Object> get props => [accountId];
}
