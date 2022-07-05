import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expanse_app/widgets/user_transactions_widgets/new_transaction_widget.dart';
import 'package:personal_expanse_app/widgets/user_transactions_widgets/transaction_list_widget.dart';
import '../model/transaction.dart';
import '../values/strings.dart';
import '../widgets/chart_widgets/chart_widget.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Week Groceries', amount: 39.99, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'New Pent', amount: 49.99, date: DateTime.now()),
    // Transaction(
    //     id: 't4', title: 'New Socks', amount: 19.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  //Method to add new transaction to _recentTransaction list!
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newxTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newxTx);
    });
  }

  //Method to open showModalBottomSheet and pass this method to NewTransaction Screen!
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      // isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
              addTx: _addNewTransaction,
            ));
      },
    );
  }

  //Method for delete transaction!
  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  // bool function for switch function!
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape; // we check screen orientation!

    // store appBar in this variable!
    final appBar = AppBar(
        title: const Text(appbarTitle),
        elevation: 0.0,
        actions: [
      IconButton(
        onPressed: () => _startAddNewTransaction(context),
        icon: const Icon(Icons.add),
      )
    ],
    );

    final txListWidget = SizedBox(
      height: (mediaQuery.size.height - appBar.preferredSize.height- mediaQuery.padding.top) * 0.7,
      child: TransactionList(
        transactions: _userTransaction,
        deleteTx: _deleteTransaction,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      // appBar:  const CustomAppBarWidget(
      //   title: appbarTitle,
      //   color: colorPrimary,
      // // icon: Icon(Icons.add),
      // ),

      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text('Show Chart'),
                Switch.adaptive(
                  value: _showChart ,
                    onChanged: (val) {
                    setState((){
                      _showChart = val;
                    });
                    },
                )
              ],
              ),
             if(!isLandscape)
               SizedBox(
               height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
               child: ChartWidget(
                 recentTransactions: _recentTransaction,
               ),
             ),
             if(!isLandscape)
               txListWidget,
              if(isLandscape)
              _showChart ?  SizedBox(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: ChartWidget(
                  recentTransactions: _recentTransaction,
                ),
              )
                 :  txListWidget,
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Platform.isIOS ? Container()
          : FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );

  }
}
