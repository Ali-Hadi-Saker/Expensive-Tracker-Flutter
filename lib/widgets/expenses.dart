import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenes_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpenses = [
    Expense(
      amount: 19.99,
      date: DateTime.now(),
      title: 'Flutter course',
      category: Category.work,
    ),
    Expense(
      amount: 15,
      date: DateTime.now(),
      title: 'Cinema',
      category: Category.leisure,
    ),
  ];

  void _openAddNewExpense() {
    showModalBottomSheet(
      useSafeArea: true,//make sure to stay away from camera
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addNewExpense),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      _registredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registredExpenses.indexOf(expense);
    setState(() {
      _registredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expended Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Center(child: Text('No Expesnes Exist'));

    if (_registredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Tracker'),
        actions: [
          IconButton(onPressed: _openAddNewExpense, icon: Icon(Icons.add)),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
