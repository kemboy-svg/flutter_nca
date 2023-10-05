

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/serverResponse_model.dart';
import 'package:nca/repos/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepo _signUpRepo;

  SignUpBloc(this._signUpRepo) : super(SignUpInitial()) {
    on<SignUpButtonTapped>((event, emit) async {
      emit(SigningUp());
      try {
        final response = await _signUpRepo.signupUser(
            event.firstname,
            event.lastname,
            event.email,
            event.phone,
            event.password,
            event.confPassword);
        if (response == true) {
          emit(SignedUpSuccess());

          print("Signed up successfully");
        } else if(response is ServerResponse) {
          
        emit(SignedUpFailure(serverResponse: response));
        print("responses ${response.message},${response.status}");
        }
        
      } catch (e) {
        print("error on signup${e.toString()}");
        // emit(SignedUpFailure(error: "unknown error"));
      }
    });
  }
}
