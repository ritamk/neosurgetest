import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/goal/goal_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/widget/plan_bottom_sheet.dart';
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

    return InkWell(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (_) => BlocProvider(
              create: (_) => GoalBloc(),
              child: PlanBottomSheet(goal: goal, balance: balance))),
      child: Container(
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
                  scrollDirection: Axis.horizontal,
                  child: Text(formattedPlanCost),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
