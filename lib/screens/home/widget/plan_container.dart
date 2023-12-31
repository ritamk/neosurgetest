import 'package:flutter/material.dart';
import 'package:neosurgetest/models/plan_model.dart';
import 'package:neosurgetest/screens/home/widget/plan_bottom_sheet.dart';
import 'package:neosurgetest/utils/money_formatter.dart';

class PlanContainer extends StatelessWidget {
  const PlanContainer({
    super.key,
    required this.goal,
    required this.balance,
  });
  final GoalModel goal;
  final double balance;

  @override
  Widget build(BuildContext context) {
    final String formattedPlanCost = formatMoney(goal.targetAmount);
    const int completed = 80;
    const int left = 18;

    return InkWell(
      onTap: () async => await planBottomSheet(context, goal, balance),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black.withOpacity(0.05),
        ),
        height: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                goal.planName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formattedPlanCost),
                      const Text('$completed% achieved'),
                      const Text('$left days left'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
