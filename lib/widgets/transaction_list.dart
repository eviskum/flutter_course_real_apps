import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('No transactions yet !!!', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 20),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                        icon: Icon(Icons.delete),
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
            ),
    );
  }
}
