import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deletTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deletTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount} '),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            // ignore: deprecated_member_use
            ? FlatButton.icon(
                onPressed: () {
                  widget.deletTx(widget.transaction.id);
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
                  widget.deletTx(widget.transaction.id);
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
