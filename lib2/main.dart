import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MaterialApp(
    title: 'Expense Planner',
    home: MainPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0)))),
  ));
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  String title;
  String amount;

  final List<Transaction> userTransaction = [
//    Transaction(id: 't1', title: 't-shirt', exp: 600, date: DateTime.now()),
//    Transaction(id: 't2', title: 'shirt', exp: 700, date: DateTime.now()),
//    Transaction(id: 't1', title: 't-shirt', exp: 600, date: DateTime.now()),
//    Transaction(id: 't2', title: 'shirt', exp: 700, date: DateTime.now()),
//    Transaction(id: 't1', title: 't-shirt', exp: 600, date: DateTime.now()),
//    Transaction(id: 't2', title: 'shirt', exp: 700, date: DateTime.now())
  ];

  List<Transaction> get _recents {
    return userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNew(String txtitle, double txamount,DateTime selecteddate) {
    final newTx = Transaction(
        title: txtitle,
        exp: txamount,
        date: selecteddate,
        id: DateTime.now().toString());
    setState(() {
      userTransaction.add(newTx);
    });
  }

  void deleteTx(String id){
     setState(() {
       return userTransaction.removeWhere((tx){tx.id==id;});
     });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: newtransaction(addNew),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanse Planner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 35.0,
            color: Colors.white,
            onPressed: () {
              startAddNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(_recents),
            transaction_list(userTransaction,deleteTx)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35.0,
        ),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
