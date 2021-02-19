import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  TransactionList(this.transactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactionList.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction',
                  style: TextStyle(color: Colors.redAccent, fontSize: 40),
                ),
                Container(
                    color: Colors.red[100],
                    height: 200,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                          child: Text('\$${transactionList[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(transactionList[index].title),
                    subtitle: Text(
                        DateFormat.yMMM().format(transactionList[index].date)),
                  ),
                );
              },
              itemCount: transactionList.length),
    );
  }
}
