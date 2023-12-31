// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neosurgetest/feature/auth/data/models/user_model.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';

class DashboardModel {
  final MyUserModel user;
  final List<ExpenseModel> expenses;
  final List<GoalModel> goals;

  DashboardModel({
    required this.user,
    required this.expenses,
    required this.goals,
  });
}
