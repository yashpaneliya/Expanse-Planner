import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String title;
  final double exp;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.exp,
    @required this.date
});
}