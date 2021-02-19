import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if (enterAmount <= 0 || enterTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(enterTitle, enterAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen'
                        : 'Picked date ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                      onPressed: _presentDatePicker, child: Text('Choose date'))
                ],
              ),
            ),
            RaisedButton(
                textColor: Colors.blue,
                color: Colors.amberAccent,
                onPressed: _submitData,
                child: Text('Add transaction'))
          ],
        ),
      ),
    );
  }
}
