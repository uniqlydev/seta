part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}


// final class DashboardLoaded extends DashboardState {
//   final List<FireBaseUser> patients;

//   const DashboardLoaded({required this.patients});

//   @override
//   List<Object> get props => [patients];
// }
