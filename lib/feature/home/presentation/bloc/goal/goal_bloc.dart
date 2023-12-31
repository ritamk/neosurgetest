import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/domain/repo/db_repo.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(GoalInitial()) {
    on<AddingGoal>((event, emit) async {
      emit(GoalSubmitting());
      try {
        await DatabaseRepository().setGoal(event.goalModel);
        emit(GoalSubmitSuccess());
      } catch (e) {
        emit(GoalSubmitError());
      }
    });
    on<EditingGoal>((event, emit) async {
      emit(GoalSubmitting());
      try {
        await DatabaseRepository().updateGoal(
          event.oldGoalModel,
          event.newGoalModel,
        );
        emit(GoalSubmitSuccess());
      } catch (e) {
        emit(GoalSubmitError());
      }
    });
    on<DeletingGoal>((event, emit) async {
      emit(GoalSubmitting());
      try {
        await DatabaseRepository().removeGoal(event.goalModel);
        emit(GoalSubmitSuccess());
      } catch (e) {
        emit(GoalSubmitError());
      }
    });
  }
}
