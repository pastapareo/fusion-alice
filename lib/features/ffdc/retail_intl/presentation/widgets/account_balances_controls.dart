import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/bloc/bloc.dart';

class AccountBalancesControls extends StatefulWidget {
  AccountBalancesControls({Key key}) : super(key: key);

  @override
  _AccountBalancesControlsState createState() => _AccountBalancesControlsState();
}

class _AccountBalancesControlsState extends State<AccountBalancesControls> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Search'),
        onPressed: () {
          dispatch();
        },
      ),
    );
  }

  void dispatch() {
    BlocProvider.of<AccountInfoBloc>(context).add(GetAccountBalances('01010OA00P200'));
  }
}
