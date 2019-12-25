import 'package:equatable/equatable.dart';

abstract class AccountInfoState extends Equatable {
  const AccountInfoState();
}

class InitialAccountInfoState extends AccountInfoState {
  @override
  List<Object> get props => [];
}
