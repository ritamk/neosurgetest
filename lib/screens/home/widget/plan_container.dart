import 'package:flutter/material.dart';
import 'package:neosurgetest/utils/money_formatter.dart';

class PlanContainer extends StatelessWidget {
  const PlanContainer({
    super.key,
    required this.planName,
    required this.planCost,
    required this.planIcon,
  });
  final String planName;
  final double planCost;
  final Icon planIcon;

  @override
  Widget build(BuildContext context) {
    final String formattedPlanCost = formatMoney(planCost);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withOpacity(0.05),
      ),
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(planName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child:
                      SingleChildScrollView(child: Text(formattedPlanCost)))),
        ],
      ),
    );
  }
}
