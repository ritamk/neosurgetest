import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neosurgetest/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_expense.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_plan.dart';
import 'package:neosurgetest/feature/home/presentation/widget/balance_container.dart';
import 'package:neosurgetest/feature/home/presentation/widget/info_dialog.dart';
import 'package:neosurgetest/feature/home/presentation/widget/plan_container.dart';
import 'package:neosurgetest/feature/home/presentation/widget/txn_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            Text(
              'User Something',
              style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async => await showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (ctx) => const HomeInfoDialog()),
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.green,
            ),
            tooltip: 'Info',
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (ctx) => const SignUpScreen()),
              (route) => false,
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.green,
            ),
            tooltip: 'Logout',
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const MyBalanceContainer(net: 12000),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'My Goals',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (ctx) => const AddPlanScreen()),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.green,
                    ),
                    tooltip: 'Add goal',
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlanContainer(
                          goal: GoalModel(
                            planName: 'Car',
                            targetDate: DateTime(DateTime.now().year + 1),
                            targetAmount: 40000,
                          ),
                          balance: 120000,
                        ),
                        const SizedBox(width: 8),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxnContainer(
                        expense: ExpenseModel(
                          txnName: 'Ride',
                          isExpense: true,
                          txnAmount: 12,
                          txnDate: DateTime.now(),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (ctx) => const AddExpenseScreen()),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2))
                ]),
            height: 50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text(
                  'Add expense',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
