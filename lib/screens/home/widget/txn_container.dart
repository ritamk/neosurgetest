import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/utils/money_formatter.dart';

class TxnContainer extends StatelessWidget {
  const TxnContainer({
    super.key,
    required this.txnName,
    required this.txnCost,
    required this.txnTime,
    required this.isExpense,
  });
  final String txnName;
  final double txnCost;
  final DateTime txnTime;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    final String formattedTxnCost = formatMoney(txnCost);

    return Container(
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
            DateFormat('dd/MM').format(txnTime),
            style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.4)),
          )),
        ),
        title: Text(
          txnName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '${isExpense ? '-' : '+'} $formattedTxnCost',
          style: TextStyle(
            color: isExpense ? Colors.red : Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          DateFormat('EEEE').format(txnTime),
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
