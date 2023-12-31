part of 'goal_bloc.dart';

sealed class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object> get props => [];
}

class AddingGoal extends GoalEvent {
  const AddingGoal({required this.goalModel});

  final GoalModel goalModel;
}

class EditingGoal extends GoalEvent {
  const EditingGoal({
    required this.oldGoalModel,
    required this.newGoalModel,
  });

  final GoalModel oldGoalModel;
  final GoalModel newGoalModel;
}

class DeletingGoal extends GoalEvent {
  const DeletingGoal({required this.goalModel});

  final GoalModel goalModel;
}
