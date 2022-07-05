import 'package:flutter/material.dart';
import 'package:personal_expanse_app/model/transaction.dart';
import 'package:personal_expanse_app/utils/home_utils.dart';
import 'package:personal_expanse_app/widgets/chart_widgets/chart_bar_widget.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key, required this.recentTransactions})
      : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
    //  HomeUtils.printValue('DAY', DateFormat.E().format(weekDay));
    //  HomeUtils.printValue('AMOUNT', totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeUtils.printValue('groupedTransactionValues', groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ChartBar(
                  label: (data['day'] as String),
                  spendingAmount: (data['amount'] as double),
                  spendingPercentageOfTotal:
                     totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            ),
          );
        }).toList(),
      ),
    );
  }
}
