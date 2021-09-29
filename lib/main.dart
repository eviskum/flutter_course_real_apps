import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'models/transactions.dart';
// import './widgets/transaction_list.dart';
// import './widgets/new_transaction.dart';
import './widgets/user_transactions.dart';

void main() {
//  Intl.defaultLocale = 'da_DK';
//  initializeDateFormatting()
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Course - Real Apps'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
//  final List<Transaction> transactions = [
//    Transaction(id: 't1', title: 'Papir', amount: 12.50, date: DateTime.now()),
//    Transaction(id: 't2', title: 'Blyant', amount: 4.75, date: DateTime.now()),
//  ];

//  final titleController = TextEditingController();
//  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART'),
                elevation: 5,
              ),
            ),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
