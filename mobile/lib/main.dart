import 'package:flutter/material.dart';
import 'package:mobile/Page/RichesPage.dart';
import 'package:mobile/Page/LoginScrenn.dart';
import 'package:mobile/Page/pages.dart';
// import 'package:mobile/Page/stats.dart';
import 'package:mobile/Page/trans.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/input_provider.dart';
import 'package:mobile/providers/pendapatan_provider.dart';
import 'package:mobile/providers/pengeluaran_provider.dart';
import 'package:provider/provider.dart';

import 'Page/CheckWallet.dart';
import 'Page/RegisterScrenn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => InputProvider()),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => LoginScreen(),
            // '/register': (context) => RegisterScreen(),
            // '/login': (context) => LoginScreen(),
            '/riches':(context) => RichesPage(),
            '/checkWallet':(context) => CheckWallet(),
            '/inputHutang': (context) => InputHutang(),
            '/trans': (context) => Transaction(),
            '/home': (context) => Transaction( ),
          },
        ));
  }
}
