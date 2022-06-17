// ignore_for_file: deprecated_member_use, avoid_print, unused_import
import 'package:expence_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction_items.dart';

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
        // : ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       return TransactionItem(
        //         transaction: transactions[index],
        //         deletTx: deletTx,
        //       );
        //     },
        //     itemCount: transactions.length,
        //   );
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx.id), transaction: tx, deletTx: deletTx))
                .toList());
  }
}
