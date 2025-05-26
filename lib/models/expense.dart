import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid(); //package to generate unique id

var formater = DateFormat.yMd();

enum Category { tarvel, food, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.tarvel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id =
           uuid.v4(); //initialize method to create a unique id when creating new object

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formater.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  //alternative constaructor method to gather expenses relative to each category
  ExpenseBucket.forCategory(List<Expense> allExpenes, this.category)
    : expenses =//initializing expenses value 
          allExpenes.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    double total = 0;
    for (final expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}
