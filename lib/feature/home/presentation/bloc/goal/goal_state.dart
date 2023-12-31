part of 'goal_bloc.dart';

sealed class GoalState extends Equatable {
  const GoalState();

  @override
  List<Object> get props => [];
}

final class GoalInitial extends GoalState {}

final class GoalSubmitting extends GoalState {}

final class GoalSubmitError extends GoalState {}

final class GoalSubmitSuccess extends GoalState {}
