part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardLoading extends DashboardState {}

final class DashboardError extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final DashboardModel data;

  const DashboardSuccess(this.data);
}
