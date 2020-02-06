import 'package:meta/meta.dart';

import '../bloc.dart';

class Error extends AccountInfoState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
