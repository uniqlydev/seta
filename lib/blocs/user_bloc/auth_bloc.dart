import 'package:bloc/bloc.dart';
import 'package:codingbryant/models/FirebaseUser.dart';
import 'package:codingbryant/repositories/UserRepositories.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepostory _userRepostory;
  AuthBloc({required UserRepostory userRepostory})
    : _userRepostory = userRepostory,
      super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {

    }else if (event is AuthLoggedIn) {

    }else if (event is AuthLoggedOut) {

    }

    

    Stream<AuthState> _mapAuthStartedToState() async* {
      final isSignedIn = await _userRepostory.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepostory.getUser();
        yield AuthSuccess(user: user);
      } else {
        yield AuthFailure(message: 'Not Authenticated');
      }
    }


  }
}
