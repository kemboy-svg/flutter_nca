import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/repos/user_repository.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
   final ForgotEmailRepo _forgotEmailRepo;

  ForgotPasswordBloc(this._forgotEmailRepo) : super(ForgotPasswordInitial()) {
    on<onTappedSubmitButton>((event, emit)async {
      try {
        emit(SubmittingEmailState());
        final response =await _forgotEmailRepo.userEmail(event.Email);
        if(response==true){
          
          emit(SubmitEmailSuccess("Email sent successfully, Check you email"));
        }
        else{
          emit(SubmitEmailFailure("An error occurred"));
        }
      } catch (e) {
        print('${e.toString()} This is some error');
       emit(SubmitEmailFailure(e.toString()));
      }
    });
  }
}
