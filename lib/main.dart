import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/services.dart';

import 'models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
// import './widgets/user_transactions.dart';
import './widgets/chart.dart';

void main() {
//  Intl.defaultLocale = 'da_DK';
//  initializeDateFormatting()
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final _isIOS = !kIsWeb && Platform.isIOS;

    return // false // _isIOS
        /* ? CupertinoApp(
            title: 'Flutter Demo',
            theme: const CupertinoThemeData(
              primaryColor: Colors.purple,
              primaryContrastingColor: Colors.white,
            ),
            home: MyHomePage(title: 'Flutter Course - Real Apps..'),
          )
        : */
        MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light()
            .textTheme
            .copyWith(headline6: const TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 18)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Course - Real Apps..'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(id: 't1', title: 'Papir', amount: 12.50, date: DateTime.now()),
//    Transaction(id: 't2', title: 'Blyant', amount: 4.75, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(title: title, amount: amount, id: DateTime.now().toString(), date: date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
//    showCupertinoModalBottomSheet(
        context: context,
        builder: (_) {
//          return Container(
//            child: Text('test'),
//          );
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  // bool get isIOS { return !kIsWeb && Platform.isIOS };
  // final _isIOS = false;
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _isIOS = !kIsWeb && Platform.isIOS;

    final PreferredSizeWidget appBar = _isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.add,
                // size: 30,
              ),
              onPressed: () {
                _startAddNewTransaction(context);
              },
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () {
                    _startAddNewTransaction(context);
                  },
                  icon: const Icon(
                    Icons.add,
                  ))
            ],
          );

    final Widget _chartSwitchButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Show chart'),
        Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
      ],
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape) _chartSwitchButton,
            if (_showChart && _isLandscape)
              SizedBox(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.5,
                  child: Chart(_recentTransactions)),
            if (!_isLandscape)
              SizedBox(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                  child: Chart(_recentTransactions)),
            if (!_showChart || !_isLandscape)
              SizedBox(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                  child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
    );

    // print(MediaQuery.of(context).orientation.toString());

    return _isIOS
        ? CupertinoPageScaffold(navigationBar: appBar as ObstructingPreferredSizeWidget, child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: _isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
  }
}
