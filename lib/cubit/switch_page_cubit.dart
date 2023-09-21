import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_page_state.dart';

class SwitchPageCubit extends Cubit<SwitchPageState> {
  SwitchPageCubit() : super(LoginPageState());

  void navigateToSignUp(){
      emit(SignUpPageState());
  }
  void navigateToLogin(){
    emit (LoginPageState());
  }

}
