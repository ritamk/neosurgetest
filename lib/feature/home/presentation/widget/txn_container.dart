import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/expense/expense_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/widget/txn_bottom_sheet.dart';
import 'package:neosurgetest/utils/money_formatter.dart';

class TxnContainer extends StatelessWidget {
  const TxnContainer({
    super.key,
    required this.expense,
  });
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final String formattedTxnCost = formatMoney(expense.txnAmount);

    return InkWell(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => BlocProvider(
                create: (context) => ExpenseBloc(),
                child: TxnBottomSheet(expense: expense),
              )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black.withOpacity(0.05),
        ),
        width: double.infinity,
        child: ListTile(
          leading: Container(
            height: 50,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Center(
                child: Text(
              DateFormat('dd/MM').format(expense.txnDate),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.4)),
            )),
          ),
          title: Text(
            expense.txnName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            '${expense.isExpense ? '-' : '+'} $formattedTxnCost',
            style: TextStyle(
              color: expense.isExpense ? Colors.red : Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            DateFormat('EEEE').format(expense.txnDate),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
