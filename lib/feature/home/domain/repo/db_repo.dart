// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neosurgetest/feature/home/data/model/dashboard_model.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/auth/data/models/user_model.dart';
import 'package:neosurgetest/utils/shared_pref.dart';

class DatabaseRepository {
  final String? uid = LocalSharedPref.getUid();

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<bool> setUserData(MyUserModel user) async {
    try {
      final Map<String, dynamic> data = user.toMap();
      data.addAll({
        'expenses': [],
        'goals': [],
      });
      await _userCollection.doc(uid).set(data);
      return true;
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Stream<DashboardModel?> getUserData() {
    try {
      return _userCollection.doc(uid).snapshots().map((event) {
        final dynamic data = event.data();

        if (data != null) {
          List<ExpenseModel> expenses = [];
          List<GoalModel> goals = [];
          for (dynamic element in data['expenses']) {
            expenses.add(ExpenseModel.fromMap(element));
          }
          for (dynamic element in data['goals']) {
            goals.add(GoalModel.fromMap(element));
          }
          expenses.sort((a, b) => a.txnDate.compareTo(b.txnDate));
          goals.sort((a, b) => a.targetDate.compareTo(b.targetDate));

          return DashboardModel(
            user: MyUserModel.fromMap(data),
            expenses: expenses,
            goals: goals,
          );
        } else {
          return null;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setExpense(ExpenseModel expense) async {
    try {
      final DocumentSnapshot doc = await _userCollection.doc(uid).get();
      final dynamic data = doc.data();
      double balance = double.parse(data['balance']);
      expense.isExpense
          ? balance -= expense.txnAmount
          : balance -= expense.txnAmount;

      return await _userCollection.doc(uid).update({
        'balance': balance,
        'expenses': FieldValue.arrayUnion([
          ExpenseModel(
            txnName: expense.txnName,
            isExpense: expense.isExpense,
            txnAmount: expense.txnAmount,
            txnDate: expense.txnDate,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setGoal(GoalModel goal) async {
    try {
      return await _userCollection.doc(uid).update({
        'goals': FieldValue.arrayUnion([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    try {
      final DocumentSnapshot doc = await _userCollection.doc(uid).get();
      final dynamic data = doc.data();
      double balance = double.parse(data['balance']);
      expense.isExpense
          ? balance -= expense.txnAmount
          : balance -= expense.txnAmount;

      return await _userCollection.doc(uid).update({
        'balance': balance,
        'expenses': FieldValue.arrayRemove([
          ExpenseModel(
            txnName: expense.txnName,
            isExpense: expense.isExpense,
            txnAmount: expense.txnAmount,
            txnDate: expense.txnDate,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeGoal(GoalModel goal) async {
    try {
      return await _userCollection.doc(uid).update({
        'goals': FieldValue.arrayRemove([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateExpense(
      ExpenseModel oldExpense, ExpenseModel expense) async {
    try {
      final DocumentSnapshot doc = await _userCollection.doc(uid).get();
      final dynamic data = doc.data();
      double balance = double.parse(data['balance']);
      oldExpense.isExpense
          ? balance += oldExpense.txnAmount
          : balance -= oldExpense.txnAmount;
      expense.isExpense
          ? balance -= expense.txnAmount
          : balance += expense.txnAmount;

      await _userCollection.doc(uid).update({
        'expenses': FieldValue.arrayRemove([
          ExpenseModel(
            txnName: oldExpense.txnName,
            isExpense: oldExpense.isExpense,
            txnAmount: oldExpense.txnAmount,
            txnDate: oldExpense.txnDate,
          ).toMap()
        ])
      });
      return await _userCollection.doc(uid).update({
        'balance': balance,
        'expenses': FieldValue.arrayUnion([
          ExpenseModel(
            txnName: expense.txnName,
            isExpense: expense.isExpense,
            txnAmount: expense.txnAmount,
            txnDate: expense.txnDate,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGoal(GoalModel oldGoal, GoalModel goal) async {
    try {
      await _userCollection.doc(uid).update({
        'goals': FieldValue.arrayRemove([
          GoalModel(
            planName: oldGoal.planName,
            targetDate: oldGoal.targetDate,
            targetAmount: oldGoal.targetAmount,
          ).toMap()
        ])
      });
      return await _userCollection.doc(uid).update({
        'goals': FieldValue.arrayUnion([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      rethrow;
    }
  }
}
