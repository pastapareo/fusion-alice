import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/bloc/bloc.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/widgets/account_balances_controls.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/widgets/account_balances_display.dart';
import 'package:fusion_alice/injection_container.dart';

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Info'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<AccountInfoBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AccountInfoBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Placeholder(),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 8,
              child: BlocBuilder<AccountInfoBloc, AccountInfoState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Container(
                      child: Text('Nothing'),
                    );
                  } else if (state is Error) {
                    return Container(
                      child: Text(state.message),
                    );
                  } else if (state is Loading) {
                    return Container(
                      child: Text('Loading'),
                    );
                  } else if (state is Loaded) {
                    return AccountBalancesDisplay(
                      balances: state.balances,
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: AccountBalancesControls(),
            ),
          ],
        ),
      ),
    );
  }
}
