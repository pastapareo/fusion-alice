import 'package:flutter/material.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/pages/account_info_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Info',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: AccountInfoPage(),
    );
  }
}
