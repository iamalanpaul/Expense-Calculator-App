import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); //create instance of Uuid class to generate random id

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work
} // so that only these options are available in category

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expenses {
  Expenses(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid
            .v4(); //create initializer list to add random id which cannot be entereed by the user
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  
  //builds a second constructor which filters expenses based on category
  //builds a initializer list which filters expenses according to category
  ExpenseBucket.forCategory(List<Expenses> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)//can also write this.category
            .toList();

  final Category category;
  final List<Expenses> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
