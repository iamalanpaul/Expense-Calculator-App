import 'package:expense_calculator/widgets/chart/chart.dart';
import 'package:expense_calculator/widgets/expenses_list/expenseslist.dart';
import 'package:expense_calculator/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expenses.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});
  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Expenses> _registeredExpenses = [
    Expenses(
        title: 'flutter course',
        amount: 19.9,
        date: DateTime.now(),
        category: Category.work),
    Expenses(
        title: 'Movie',
        amount: 14.9,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addExpenseOverlay() {
    //context contains information of Expense widget and its position in widget tree
    //ctx shows information of showModalBottomSheet
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expenses expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expenses expense) {
    final expenseIndx = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndx, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);
    // print(width);
    Widget maincontent = const Center(
      //To show 'no expense' when list is empty
      child: Text('No expense found...'),
    );

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _addExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: maincontent,
                ), //since list act like column there will arise spacing problems so we use expanded widget
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: maincontent,
                ),
              ],
            ),
    );
  }
}
