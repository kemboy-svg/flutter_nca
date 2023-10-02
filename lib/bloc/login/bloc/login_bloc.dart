import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/user_model.dart';
// import 'package:nca/data/user_model.dart';   
import 'package:nca/repos/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
   

    on<LoginButtonPressed>((event, emit) async{
     emit (LoginLoading());
     try {
       final user=await _loginRepository.loginUser(
         event.username,
          event.password,
       );
      
        
        if (user != null) {
          emit(LoginSuccess(user));
        } else {
      
          emit(LoginFailure(error: "User not found"));
        }
       
     } catch (e) {
      emit(LoginFailure(error: e.toString()));
     }
    });
   
  }
}
