import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transactions.dart';

void main() {
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
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Papir', amount: 12.50, date: DateTime.now()),
    Transaction(id: 't2', title: 'Blyant', amount: 4.75, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART'),
              elevation: 5,
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '€ ${tx.amount}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tx.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(DateFormat.yMMMd().format(tx.date),
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
