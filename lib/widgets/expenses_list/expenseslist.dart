import 'package:expense_calculator/widgets/expenses_list/expenseitem.dart';
import 'package:flutter/material.dart';
import '../../models/expenses.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expenses expense) onRemoveExpense;
  final List<Expenses> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, //the length of list to be displayed
      //itemBuilder returns a function with context and index as parameters
      //function runs as many times as itemCount and each time indx incremented starting with 0
      //Dismissable used to delete list if swiped
      itemBuilder: (ctx, indx) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),// to access from main theme color variation
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),// accessing same margin parameters as set in theme data of card
        ),
        key: ValueKey(expenses[indx]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[indx]);
        },
        child: ExpItem(expenses[indx]),
      ),
    );
  }
}
