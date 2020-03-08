import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class newtransaction extends StatefulWidget {
  final Function addTx;

  newtransaction(this.addTx);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return newtransactionState();
  }
}

class newtransactionState extends State<newtransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selecteddate;

  void submitData() {
    final enteredtitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || selecteddate == null) {
      return;
    }
    widget.addTx(
      enteredtitle,
      enteredamount,
      selecteddate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selecteddate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: titleController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            onSubmitted: (_) => submitData,
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            cursorColor: Theme.of(context).primaryColor,
            onSubmitted: (_) => submitData,
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(selecteddate == null
                    ? 'No Date'
                    : 'Picked Date : ' + DateFormat.yMd().format(selecteddate)),
              ),
              SizedBox(
                width: 10.0,
              ),
              FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: presentDatePicker)
            ],
          ),
          Container(
            height: 30.0,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              submitData();
            },
          )
        ],
      ),
    ));
  }
}
