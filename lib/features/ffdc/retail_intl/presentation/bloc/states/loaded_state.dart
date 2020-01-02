import 'package:meta/meta.dart';

import '../../../domain/entities/account_balance_response.dart';
import '../bloc.dart';

class Loaded extends AccountInfoState {
  final AccountBalanceResponse balances;

  Loaded({@required this.balances});

  @override
  List<Object> get props => [balances];
}
