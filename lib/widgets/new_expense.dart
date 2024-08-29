import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_calculator/models/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expenses expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //var _inputText = '';
  // void inputTextValue(String value) {
  //   _inputText = value;
  // }
  final formatter = DateFormat.yMd();
  final _inputTextController = TextEditingController();
  final _inputAmountController = TextEditingController();
  //since not disposing this widget after use can make it run in memory unneccesarily we dispose this widget after use
  DateTime? _selectedDate; //either stores date time or NULL
  Category _selectedCategory = Category.leisure; //to store selected category

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    //the await keyword internally simply tells Flutter that this value that should be stored in pick date won't be available immediately
    //but at least at some point in the future and Flutter should therefore basically wait for that value before it stores it in that variable.
    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = date;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _inputAmountController.text); //gives null if it can't parse the text
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_inputTextController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please enter a valid title, amount, date, context....'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expenses(
        title: _inputTextController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context); //to close the overlay when expenses added
  }

  @override
  void dispose() {
    _inputTextController.dispose();
    _inputAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; //checks how much space from bottom is being taken when keyboard comes up in landscape mode
    return LayoutBuilder(builder: (ctx, constraints) {
      // for adjusting UI accordingly when constraints changed like widgets or orientation
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if(width >= 600)
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          //onChanged: inputTextValue,
                          controller: _inputTextController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: TextField(
                          controller: _inputAmountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text("Amount"),
                          ),
                        ),
                      ),


                    ],)
                  else
                    TextField(
                      //onChanged: inputTextValue,
                      controller: _inputTextController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  //Expanded neccessary so that widget does not take all the space
                  if(width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (values) {
                            if (values == null) return;
                            setState(() {
                              _selectedCategory = values;
                            });
                          }),
                        const SizedBox(width: 24,),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? 'No Date selected'
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ))
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? 'No Date selected'
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ))
                      ],
                    ),
                  const SizedBox(height: 16),
                  if(width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              _submitExpenseData();
                            },
                            child: const Text('Save Expense'))
                      ],)
                  else 
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (values) {
                              if (values == null) return;
                              setState(() {
                                _selectedCategory = values;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              _submitExpenseData();
                            },
                            child: const Text('Save Expense'))
                      ],
                    )
                ],
              )),
        ),
      );
    });
  }
}
