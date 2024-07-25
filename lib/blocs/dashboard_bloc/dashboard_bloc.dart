import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DashboardBloc({required FirebaseAuth auth, required FirebaseFirestore firestore})
    : _auth = auth,
      _firestore = firestore,
      super(DashboardInitial()) {
        on<DashboardLoad>(_onDashboardLoad);
        on<GeneratePatients>(_onGeneratePatients);
  }

  Future<void> _onDashboardLoad(DashboardLoad event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
  }

  Future<void> _onGeneratePatients(GeneratePatients event, Emitter<DashboardState> emit) async {}

}
