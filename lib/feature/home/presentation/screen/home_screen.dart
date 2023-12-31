import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurgetest/feature/auth/data/models/user_model.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/expense/expense_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/goal/goal_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_expense.dart';
import 'package:neosurgetest/feature/home/presentation/screen/add_plan.dart';
import 'package:neosurgetest/feature/home/presentation/widget/balance_container.dart';
import 'package:neosurgetest/feature/home/presentation/widget/info_dialog.dart';
import 'package:neosurgetest/feature/home/presentation/widget/plan_container.dart';
import 'package:neosurgetest/feature/home/presentation/widget/txn_container.dart';
import 'package:neosurgetest/utils/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyUserModel? _userData;
  List<ExpenseModel>? _expenses;
  List<GoalModel>? _goals;

  bool _loading = true;
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        switch (state) {
          case DashboardSuccess():
            setState(() {
              _expenses = state.data.expenses;
              _goals = state.data.goals;
              _userData = state.data.user;
              _loading = false;
            });
          case DashboardLoading():
            setState(() => _loading = true);
          case DashboardError():
            setState(() {
              _error = true;
              _loading = false;
            });
            customSnackbar(context,
                content: 'Something went wrong while fetching data',
                isError: true);
          default:
        }
      },
      child: !_loading
          ? !_error
              ? Scaffold(
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
                          _userData!.name,
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
                        onPressed: () {
                          context.read<SignInBloc>().add(SigningOut());
                        },
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
                          MyBalanceContainer(net: _userData!.balance),
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
                                      builder: (ctx) => BlocProvider(
                                            create: (context) => GoalBloc(),
                                            child: const AddPlanScreen(),
                                          )),
                                ),
                                icon: const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Colors.green,
                                ),
                                tooltip: 'Add goal',
                              ),
                            ],
                          ),
                          _goals!.isNotEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _goals!.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PlanContainer(
                                            goal: GoalModel(
                                              planName: _goals![index].planName,
                                              targetDate:
                                                  _goals![index].targetDate,
                                              targetAmount:
                                                  _goals![index].targetAmount,
                                            ),
                                            balance: _userData!.balance,
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('No goals added'),
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
                          _expenses!.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _expenses!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TxnContainer(
                                          expense: ExpenseModel(
                                            txnName: _expenses![index].txnName,
                                            isExpense:
                                                _expenses![index].isExpense,
                                            txnAmount:
                                                _expenses![index].txnAmount,
                                            txnDate: _expenses![index].txnDate,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    );
                                  },
                                )
                              : const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('No transactions added'),
                                  ),
                                ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) => BlocProvider(
                                  create: (context) => ExpenseBloc(),
                                  child: const AddExpenseScreen(),
                                )),
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
                              'Add transaction',
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
                )
              : const Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mood_bad, color: Colors.red),
                      SizedBox(height: 5),
                      Text('Could not load data',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  )),
                )
          : const Scaffold(
              body: Center(
                  child: CupertinoActivityIndicator(
                color: Colors.black,
              )),
            ),
    );
  }
}
