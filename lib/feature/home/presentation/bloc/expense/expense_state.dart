part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}

final class ExpenseSubmitting extends ExpenseState {}

final class ExpenseSubmitError extends ExpenseState {}

final class ExpenseSubmitSuccess extends ExpenseState {}
