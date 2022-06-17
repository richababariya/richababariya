//import 'package:flutter/cupertino.dart';
// ignore_for_file: unused_import, avoid_print

import 'dart:io';
import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';
import 'package:flutter/services.dart';
import '../widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expence Application',
      theme: ThemeData(
        primarySwatch:
            Colors.purple, //defult to automatic genrate color in widget
        //accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: 'DancingScript',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              // button: const TextStyle(color: Colors.white),
            ),
        // appBarTheme: AppBarTheme(
        //   // ignore: deprecated_member_use
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //         titleMedium: const TextStyle(
        //             fontFamily: 'DancingScript',
        //             fontSize: 30,
        //             fontWeight: FontWeight.bold),
        //       ),
        // ),
      ),
      home: const MyAppState(),
    );
  }
}

class MyAppState extends StatefulWidget {
  const MyAppState({Key? key}) : super(key: key);

  // late String titleInput;
  // late String amountInput;

  @override
  State<MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 'a1',
    //   title: 'New Shoes',
    //   amount: 99.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'a2',
    //   title: 'New Cloth',
    //   amount: 39.25,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'a3',
    //   title: 'New Cloth',
    //   amount: 39.25,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'a4',
    //   title: 'New Cloth',
    //   amount: 39.25,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'a5',
    //   title: 'New Cloth',
    //   amount: 39.25,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deletTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyAppStateState');
    //final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // final PreferredSizeWidget appBar =  Platform.isIOS
    //     ? CupertinoNavigationBar(
    //         middle: const Text('Personal Expence'),
    //         trailing: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             GestureDetector(
    //               child: const Icon(CupertinoIcons.add),
    //               onTap: () {
    //                 _startAddNewTransaction(context);
    //               },
    //             ),
    //           ],
    //         ),
    //       )
    //     :AppBar(
    //   backgroundColor: Colors.purple,
    //   title: const Text(
    //     'Personal Expence',
    //     style: TextStyle(
    //       fontFamily: 'DancingScript',
    //       fontWeight: FontWeight.bold,
    //       fontSize: 36,
    //     ),
    //   ),
    //   actions: [
    //     IconButton(
    //       onPressed: () {
    //         _startAddNewTransaction(context);
    //       },
    //       icon: const Icon(Icons.add),
    //     ),
    //   ],
    // );

    final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: const Text(
        'Personal Expence',
        style: TextStyle(
          fontFamily: 'DancingScript',
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );

    //print(appBar.preferredSize.height);
    final txListWidget = SizedBox(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deletTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.35,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );
    return
        // Platform.isIOS
        //     ? CupertinoPageScaffold(
        //         child: pageBody,
        //         //navigationBar: appBar,
        //       ) :
        Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          // Platform.isIOS
          //     ? Container()
          //     :
          FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
