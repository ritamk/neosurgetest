// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';

import 'package:neosurgetest/feature/auth/data/models/user_model.dart';
import 'package:neosurgetest/utils/shared_pref.dart';

class DatabaseRepository {
  // DatabaseRepository({this.uid});

  // final String? uid;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<bool> setUserData(MyUserModel user) async {
    try {
      await _userCollection.doc(LocalSharedPref.getUid()).set({
        "uid": user.uid,
        "name": user.name,
        "email": null,
        "goals": [],
        "expenses": [],
      }).onError((error, stackTrace) => false);
      return true;
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Stream<MyUserModel?> getUserData() {
    try {
      return _userCollection
          .doc(LocalSharedPref.getUid())
          .snapshots()
          .map((event) {
        final dynamic data = event.data();

        if (data != null) {
          return MyUserModel.fromMap(data);
        } else {
          return null;
        }
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Stream<List<ExpenseModel>?> getExpenses() {
    try {
      return _userCollection
          .doc(LocalSharedPref.getUid())
          .snapshots()
          .map((event) {
        final dynamic data = event.data();

        if (data != null) {
          List<ExpenseModel> expenses = [];
          for (dynamic element in data['expenses']) {
            expenses.add(ExpenseModel.fromMap(element));
          }
          return expenses;
        } else {
          return null;
        }
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Stream<List<GoalModel>?> getGoals() {
    try {
      return _userCollection
          .doc(LocalSharedPref.getUid())
          .snapshots()
          .map((event) {
        final dynamic data = event.data();

        if (data != null) {
          List<GoalModel> goals = [];
          for (dynamic element in data['goals']) {
            goals.add(GoalModel.fromMap(element));
          }
          return goals;
        } else {
          return null;
        }
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Future<void> setExpense(ExpenseModel expense) async {
    try {
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
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
      throw "Something went wrong ($e)";
    }
  }

  Future<void> setGoal(GoalModel goal) async {
    try {
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
        'goals': FieldValue.arrayUnion([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    try {
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
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
      throw "Something went wrong ($e)";
    }
  }

  Future<void> removeGoal(GoalModel goal) async {
    try {
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
        'goals': FieldValue.arrayRemove([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }

  Future<void> updateExpense(
      ExpenseModel oldExpense, ExpenseModel expense) async {
    try {
      await _userCollection.doc(LocalSharedPref.getUid()).update({
        'expenses': FieldValue.arrayRemove([
          ExpenseModel(
            txnName: oldExpense.txnName,
            isExpense: oldExpense.isExpense,
            txnAmount: oldExpense.txnAmount,
            txnDate: oldExpense.txnDate,
          ).toMap()
        ])
      });
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
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
      throw "Something went wrong ($e)";
    }
  }

  Future<void> updateGoal(GoalModel oldGoal, GoalModel goal) async {
    try {
      await _userCollection.doc(LocalSharedPref.getUid()).update({
        'goals': FieldValue.arrayRemove([
          GoalModel(
            planName: oldGoal.planName,
            targetDate: oldGoal.targetDate,
            targetAmount: oldGoal.targetAmount,
          ).toMap()
        ])
      });
      return await _userCollection.doc(LocalSharedPref.getUid()).update({
        'goals': FieldValue.arrayUnion([
          GoalModel(
            planName: goal.planName,
            targetDate: goal.targetDate,
            targetAmount: goal.targetAmount,
          ).toMap()
        ])
      });
    } catch (e) {
      throw "Something went wrong ($e)";
    }
  }
}
