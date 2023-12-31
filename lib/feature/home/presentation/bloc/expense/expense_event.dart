part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class AddingExpense extends ExpenseEvent {
  const AddingExpense({required this.expenseModel});

  final ExpenseModel expenseModel;
}

class EditingExpense extends ExpenseEvent {
  const EditingExpense({
    required this.oldExpenseModel,
    required this.newExpenseModel,
  });

  final ExpenseModel oldExpenseModel;
  final ExpenseModel newExpenseModel;
}

class DeletingExpense extends ExpenseEvent {
  const DeletingExpense({required this.expenseModel});

  final ExpenseModel expenseModel;
}
