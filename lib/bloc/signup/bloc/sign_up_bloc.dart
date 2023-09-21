import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/repos/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepo _signUpRepo;

  SignUpBloc(this._signUpRepo) : super(SignUpInitial()) {
    on<SignUpButtonTapped>((event, emit) async {
      emit(SigningUp());
      try {
        final success = await _signUpRepo.signupUser(event.firstname,
            event.lastname, event.email, event.phone, event.password);
            if (success){
              emit (SignedUpSuccess());

              print("Signed up successfully");
            }
            else{
              emit (SignedUpFailure(error: "An error occurred"));
            }
      } catch (e) {
        emit(SignedUpFailure(error: "unknown error"));
      }
    });
  }
}
