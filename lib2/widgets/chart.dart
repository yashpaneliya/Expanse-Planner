import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].exp;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  //method to find total spending of a week
  double get totalSpending {
    return groupedTransaction.fold(0.0, (sum, item) {
      //sum  : currently calculated sum
      //item : item to be used
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransaction);
    // TODO: implement build
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((data) {
        return Flexible(
          fit: FlexFit.tight,
            child:ChartBar(
          data['day'],
          data['amount'],
          totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
        ));
      }).toList()),
    );
  }
}
