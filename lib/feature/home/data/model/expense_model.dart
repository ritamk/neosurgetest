// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  final String txnName;
  final bool isExpense;
  final double txnAmount;
  final DateTime txnDate;
  const ExpenseModel({
    required this.txnName,
    required this.isExpense,
    required this.txnAmount,
    required this.txnDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'txnName': txnName,
      'isExpense': isExpense,
      'txnAmount': txnAmount,
      'txnDate': txnDate.millisecondsSinceEpoch,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      txnName: map['txnName'] as String,
      isExpense: map['isExpense'] as bool,
      txnAmount: map['txnAmount'] as double,
      txnDate: DateTime.fromMillisecondsSinceEpoch(map['txnDate'] as int),
    );
  }

  @override
  List<Object> get props => [txnName, isExpense, txnAmount, txnDate];
}
