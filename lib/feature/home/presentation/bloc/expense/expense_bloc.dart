import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/domain/repo/db_repo.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<AddingExpense>((event, emit) async {
      emit(ExpenseSubmitting());
      try {
        await DatabaseRepository().setExpense(event.expenseModel);
        emit(ExpenseSubmitSuccess());
      } catch (e) {
        emit(ExpenseSubmitError());
      }
    });
    on<EditingExpense>((event, emit) async {
      emit(ExpenseSubmitting());
      try {
        await DatabaseRepository().updateExpense(
          event.oldExpenseModel,
          event.newExpenseModel,
        );
        emit(ExpenseSubmitSuccess());
      } catch (e) {
        emit(ExpenseSubmitError());
      }
    });
    on<DeletingExpense>((event, emit) async {
      emit(ExpenseSubmitting());
      try {
        await DatabaseRepository().removeExpense(event.expenseModel);
        emit(ExpenseSubmitSuccess());
      } catch (e) {
        emit(ExpenseSubmitError());
      }
    });
  }
}
