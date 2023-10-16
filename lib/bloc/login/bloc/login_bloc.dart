import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/serverResponse_model.dart';
import 'package:nca/data/user_model.dart';
import 'package:nca/repos/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await _loginRepository.loginUser(
          event.username,
          event.password,
        );
        if (event.rememberMe) {
          // If "Remember Me" is checked, save the credentials
          final credentials = UserCredentials(
            email: event.username,
            password: event.password,
          );
          saveCredentials(credentials);
        }

        if (response.success) {
          emit(LoginSuccess(response.userDetails!));
        } else {
          if (response.error is ServerResponse) {
            emit(
                LoginFailure(serverResponse: response.error as ServerResponse));
          } else {
            
             emit(LoginNOSuccess(error: response.error.toString()));
          }
        }
      } catch (e) {
        // emit(LoginFailure(e: e.toString()));
      }
    });

    
  }
}


