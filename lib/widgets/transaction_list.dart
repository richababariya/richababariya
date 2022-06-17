// ignore_for_file: deprecated_member_use, avoid_print

import 'package:expence_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletTx;
  const TransactionList(this.transactions, this.deletTx, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build() Transaction_list');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'no transaction added yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/wings.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount} '),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () {
                            deletTx(transactions[index].id);
                          },
                          icon: const Icon(Icons.delete),
                          textColor: Colors.red,
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                                fontFamily: 'DancingScript', fontSize: 22),
                          ),
                          //textcolor: Colors.red,
                          // color: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          onPressed: () {
                            deletTx(transactions[index].id);
                          },
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete',
                          color: Colors.red,
                          // color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
