// ignore_for_file: deprecated_member_use, unused_import, unnecessary_import

import 'dart:io';
import 'adaptive_flat_button.dart';
import 'package:expence_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  Function addTx;

  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    // ignore: unnecessary_null_comparison
    if (enteredTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enterAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // ignore: avoid_print
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        //'no date choose'
                        // ignore: unnecessary_null_comparison
                        _selectedDate == null
                            ? 'no date choosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        style: const TextStyle(
                          fontFamily: 'DancingScript',
                          fontSize: 26,
                        ),
                      ),
                    ),
                    AdaptiveFlatButton('choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                padding: const EdgeInsets.all(20),
                elevation: 6,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                //textColor: Theme.of(context).textTheme.button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
