import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanse_app/values/colors.dart';
import 'package:sizer/sizer.dart';
import '../../values/dimensions.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;


  //Method to add new transaction
  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if(enteredTitle.isEmpty || enteredAmount<= 0 || _selectedDate == null){
   //   Get.snackbar('Invalid', 'Enter some text', backgroundColor: Colors.red);
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  //Method for date picker!
  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null){
        return null;
      }
     setState((){
       _selectedDate = pickedDate;
     });
    });

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10,
              bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
               // autofocus: true,
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
             //   autofocus: true,
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 7.h,
                child: Row(
                  children: [
                     Expanded(
                       child: Text(
                          _selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${(DateFormat.yMd().format(_selectedDate!))}',
                    ),
                     ),
                    TextButton(
                      onPressed: _presentDatePicker,
                       child: const Text('Choose Date',
                      style: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitData;
                  // HomeUtils.printValue('Title', titleController.text);
                  // HomeUtils.printValue('Amount', amountController.text);
                },
                child: const Text('Add Transactions',
                style: TextStyle(
                  fontSize: textAverage,
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
