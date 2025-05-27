import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void _datePicker() async {
    //use async/await to handle futur type of showDatePicker
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    //use setState to change UI when date is selected
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    //tryParse('string')=>null , tryParse('12.3')=>12.3
    final amount = double.tryParse(_amountController.text);

    bool isWrongAmount = amount == null || amount <= 0;
    if (_textController.text.trim().isEmpty ||
        isWrongAmount ||
        selectedDate == null) {
      //display error
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Data'),
              content: Text('Please Enter valid Expense Input'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Okay'),
                ),
              ],
            ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        amount: amount,
        date: selectedDate!,
        title: _textController.text,
        category: selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLength: 50,
              decoration: InputDecoration(label: Text('Tilte')),
            ),
            Row(
              children: [
                Expanded(
                  //use expanded cz textField cause conflict with row
                  child: TextField(
                    controller: _amountController,
                    maxLength: 50,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$ ',
                    ),
                  ),
                ),
                Expanded(
                  //use expanded cause row inside row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        selectedDate == null
                            ? 'No date selected'
                            : formater.format(selectedDate!),
                      ),
                      SizedBox(width: 15),
                      IconButton(
                        onPressed: _datePicker,
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                DropdownButton(
                  value: selectedCategory,
                  items:
                      Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value:
                                  category, //the value is passed to onChange function
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => {
                        setState(() {
                          selectedCategory = value!;
                        }),
                      },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text('Save Expense'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
