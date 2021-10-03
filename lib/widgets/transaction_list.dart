import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text('No transactions yet !!!', style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, idx) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text('€ ${transactions[idx].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(transactions[idx].title, style: Theme.of(context).textTheme.headline6),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[idx].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTx(transactions[idx].id);
                      }),
                ),
              );
//                return Card(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                        decoration: BoxDecoration(
//                          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
//                        ),
//                        padding: const EdgeInsets.all(10),
//                        child: Text(
//                          '€ ${transactions[idx].amount.toStringAsFixed(2)}',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),
//                        ),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(transactions[idx].title, style: Theme.of(context).textTheme.headline6),
//                          Text(DateFormat.yMMMd().format(transactions[idx].date),
//                              style: const TextStyle(color: Colors.grey)),
//                        ],
//                      )
//                    ],
//                  ),
//                );
            },
            itemCount: transactions.length,
          );
  }
}
