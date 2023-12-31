import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosurgetest/feature/home/data/model/dashboard_model.dart';
import 'package:neosurgetest/feature/home/domain/repo/db_repo.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    DatabaseRepository().getUserData().listen((event) {
      add(GetDashboardData(dashboardData: event));
    });
    on<GetDashboardData>(
      (event, emit) {
        emit(DashboardLoading());
        if (event.dashboardData != null) {
          emit(DashboardSuccess(event.dashboardData!));
        } else {
          emit(DashboardError());
        }
      },
    );
  }
}
