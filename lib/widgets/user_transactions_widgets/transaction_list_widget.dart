import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/transaction.dart';
import '../../values/colors.dart';
import '../../values/dimensions.dart';
import '../../values/strings.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList({Key? key,required this.deleteTx, required this.transactions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
      builder: (context, constraints) {
       return Center(
          child: Column(
            children:  [
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              const Text(
                defaultTextForNoTransactions,
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: headingTextSize,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Image.asset('assets/images/apple.png', fit: BoxFit.cover, height: constraints.maxHeight * 0.6,),
            ],
          ),
        );
      })

        : SingleChildScrollView(
      scrollDirection: Axis.vertical,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (ctx, index){
            return Card(
              color: Colors.blueGrey[50],
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(06.0),
                    child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                  ),
                ),
               title: Text(
                   transactions[index].title,
                 style: const TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: headingTextSize,
                   color: colorPrimary,
                 ),
               ),
                subtitle: Text(
                  DateFormat.yMMMd()
                      .format(transactions[index].date),
                  style: const TextStyle(
                    color: colorGrey,
                     fontWeight: FontWeight.bold,
                    fontSize: textAverage,
                  ),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                    ? TextButton.icon(
                    onPressed: ()=> deleteTx(transactions[index].id),
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    label: const Text('Delete', style: TextStyle(color: Colors.red),),
                )
                : IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red,),
                  onPressed: ()=> deleteTx(transactions[index].id),
                ),
              ),
            );
          }
    ),
        );
  }
}

