import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_plan.dart';
import 'package:neosurgetest/utils/money_formatter.dart';

Future<void> planBottomSheet(
    BuildContext context, GoalModel goal, double balance) async {
  final int daysLeft = goal.targetDate.difference(DateTime.now()).inDays;
  final String formattedAmt = formatMoney(goal.targetAmount);
  final String formattedBalance = formatMoney(balance);
  int targetAchieved = ((balance / goal.targetAmount) * 100).floor();

  if (targetAchieved > 100) {
    targetAchieved = 100;
  } else if (targetAchieved < 0) {
    targetAchieved = 0;
  }

  await showModalBottomSheet(
    context: context,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(goal.planName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (ctx) => AddPlanScreen(goal: goal)));
                },
                icon: const Icon(Icons.edit),
                visualDensity: VisualDensity.compact,
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
              Text(
                  'Target date: ${DateFormat('dd/MM/yy').format(goal.targetDate)}'),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                      '(${daysLeft.abs()} days ${daysLeft < 0 ? 'ago' : 'left'})')),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: targetAchieved <= 25
                      ? [
                          Colors.red.shade400,
                          Colors.red.shade600,
                        ]
                      : targetAchieved <= 75
                          ? [
                              Colors.orange.shade400,
                              Colors.orange.shade600,
                            ]
                          : [
                              Colors.green.shade400,
                              Colors.green.shade600,
                            ],
                )),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Target amount:',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(formattedAmt,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('$targetAchieved% target achieved',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 5),
                      Text('(Current balance: $formattedBalance)',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  targetAchieved <= 25
                      ? Icons.sentiment_very_dissatisfied_rounded
                      : targetAchieved <= 75
                          ? Icons.sentiment_neutral
                          : Icons.sentiment_very_satisfied_rounded,
                  color: targetAchieved <= 25
                      ? Colors.red.shade300
                      : targetAchieved <= 75
                          ? Colors.orange.shade300
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
