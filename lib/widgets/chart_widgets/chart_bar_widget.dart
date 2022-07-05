import 'package:flutter/material.dart';
import 'package:personal_expanse_app/values/colors.dart';
import 'package:sizer/sizer.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal})
      : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 3.w,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
