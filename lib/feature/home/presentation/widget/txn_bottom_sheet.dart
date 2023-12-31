import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/expense/expense_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_expense.dart';
import 'package:neosurgetest/utils/snackbar.dart';

class TxnBottomSheet extends StatefulWidget {
  const TxnBottomSheet({super.key, required this.expense});
  final ExpenseModel expense;

  @override
  State<TxnBottomSheet> createState() => _TxnBottomSheetState();
}

class _TxnBottomSheetState extends State<TxnBottomSheet> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.expense.txnName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (ctx) => BlocProvider(
                                create: (context) => ExpenseBloc(),
                                child:
                                    AddExpenseScreen(expense: widget.expense),
                              )));
                },
                icon: const Icon(Icons.edit),
                visualDensity: VisualDensity.compact,
              ),
              BlocListener<ExpenseBloc, ExpenseState>(
                listener: (context, state) {
                  switch (state) {
                    case ExpenseSubmitting():
                      setState(() => _deleting = true);
                    case ExpenseSubmitError():
                      setState(() => _deleting = false);
                      customSnackbar(context,
                          content: 'Could not delete transation',
                          isError: true);
                    case ExpenseSubmitSuccess():
                      setState(() => _deleting = false);
                      customSnackbar(context,
                          content: 'Transaction deleted', isError: false);
                      Navigator.pop(context);
                    default:
                  }
                },
                child: IconButton(
                  onPressed: () {
                    context
                        .read<ExpenseBloc>()
                        .add(DeletingExpense(expenseModel: widget.expense));
                  },
                  icon: !_deleting
                      ? const Icon(Icons.delete_forever_rounded)
                      : const Center(
                          child:
                              CupertinoActivityIndicator(color: Colors.black)),
                  visualDensity: VisualDensity.compact,
                ),
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
                  child: Text(DateFormat('dd MMMM, y (EEEE)')
                      .format(widget.expense.txnDate))),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.expense.isExpense
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
                        '${widget.expense.isExpense ? '-' : '+'} ₹ ${widget.expense.txnAmount}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                const SizedBox(width: 5),
                Icon(
                  widget.expense.isExpense
                      ? Icons.sentiment_dissatisfied_rounded
                      : Icons.sentiment_very_satisfied_rounded,
                  color: widget.expense.isExpense
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                  size: 48,
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
        ],
      ),
    );
  }
}
