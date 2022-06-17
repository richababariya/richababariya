// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChartBar(this.lable, this.spendingAmount, this.spendingPctOfTotal);

  final lable;
  final spendingAmount;
  final spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    return LayoutBuilder(
      // ignore: non_constant_identifier_names
      builder: (ctx, Constraints) {
        return Column(
          children: [
            SizedBox(
                height: Constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0.0)}'))),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(lable)),
            ),
          ],
        );
      },
    );
  }
}
