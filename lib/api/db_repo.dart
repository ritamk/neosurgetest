import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neosurgetest/models/expense_model.dart';
import 'package:neosurgetest/models/plan_model.dart';
import 'package:neosurgetest/models/user_model.dart';

class DatabaseRepository {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<bool> setUserData(MyUserModel user) async {
    try {
      await _userCollection.doc(user.uid).set({
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

  Stream<MyUserModel?> getUserData(String uid) {
    try {
      return _userCollection.doc(uid).snapshots().map((event) {
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

  Stream<List<ExpenseModel>?> getExpenses(String uid) {
    try {
      return _userCollection.doc(uid).snapshots().map((event) {
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

  Stream<List<GoalModel>?> getGoals(String uid) {
    try {
      return _userCollection.doc(uid).snapshots().map((event) {
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

  Future<void> setExpense(String uid, ExpenseModel expense) async {
    try {
      return await _userCollection.doc(uid).update({
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

  Future<void> setGoal(String uid, GoalModel goal) async {
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
      throw "Something went wrong ($e)";
    }
  }

  Future<void> removeExpense(String uid, ExpenseModel expense) async {
    try {
      return await _userCollection.doc(uid).update({
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

  Future<void> removeGoal(String uid, GoalModel goal) async {
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
      throw "Something went wrong ($e)";
    }
  }
}
