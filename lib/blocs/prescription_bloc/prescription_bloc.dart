import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc() : super(PrescriptionInitial()) {
    on<PrescriptionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
