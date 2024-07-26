part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  DashboardEvent();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  List<Object> get props => [];
}

class DashboardLoad extends DashboardEvent {
  final String uid;

  DashboardLoad({required this.uid});

  @override
  List<Object> get props => [uid];
}

class GeneratePatients extends DashboardEvent {
  final String uid;

  GeneratePatients({required this.uid});

  @override
  List<Object> get props => [uid];
}
