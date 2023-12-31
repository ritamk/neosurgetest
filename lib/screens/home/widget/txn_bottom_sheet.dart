import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/models/expense_model.dart';

Future<void> txnBottomSheet(BuildContext context, ExpenseModel expense) async {
  await showModalBottomSheet(
    context: context,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(expense.txnName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.black.withOpacity(0.4),
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                      DateFormat('dd MMMM, y (EEEE)').format(expense.txnDate))),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: expense.isExpense
                      ? [
                          Colors.red.shade400,
                          Colors.red.shade600,
                        ]
                      : [
                          Colors.green.shade400,
                          Colors.green.shade600,
                        ],
                )),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Text('Amount:', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 5),
                Expanded(
                    child: Text(
                        '${expense.isExpense ? '-' : '+'} ₹ ${expense.txnAmount}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                const SizedBox(width: 5),
                Icon(
                  expense.isExpense
                      ? Icons.sentiment_dissatisfied_rounded
                      : Icons.sentiment_very_satisfied_rounded,
                  color: expense.isExpense
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                  size: 48,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );
}
