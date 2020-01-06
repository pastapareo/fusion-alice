import 'package:flutter/material.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/entities/account_balance_response.dart';

class AccountBalancesDisplay extends StatelessWidget {
  final AccountBalanceResponse balances;

  const AccountBalancesDisplay({Key key, @required this.balances}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: balances.balances == null ? 0 : balances.balances.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                balances.balances[index].type,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                '01010OA00P200',
                style: TextStyle(fontSize: 20),
              ),
              Text(balances.balances[index].amount.amount),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
