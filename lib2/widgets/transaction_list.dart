import 'package:flutter/material.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';

class transaction_list extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;

  transaction_list(this.transactions,this.delTx);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 487,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber, width: 4.0)),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Rs. ${transactions[index].exp.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          Text(
                            DateFormat.yMMMMd()
                                .format(transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )),
                      FlatButton(
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () => delTx(transactions[index].id),
                      )
                    ],
                  ),
                  elevation: 5,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
