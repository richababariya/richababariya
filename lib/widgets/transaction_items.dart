import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deletTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deletTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text('\$${transaction.amount} '),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () {
                  deletTx(transaction.id);
                },
                icon: const Icon(Icons.delete),
                textColor: Colors.red,
                label: const Text(
                  'Delete',
                  style: TextStyle(fontFamily: 'DancingScript', fontSize: 22),
                ),
                //textcolor: Colors.red,
                // color: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () {
                  deletTx(transaction.id);
                },
                icon: const Icon(Icons.delete),
                tooltip: 'Delete',
                color: Colors.red,
                // color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
