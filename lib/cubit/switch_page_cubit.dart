import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nca/pages/projects_page.dart';

part 'switch_page_state.dart';

class SwitchPageCubit extends Cubit<SwitchPageState> {
  SwitchPageCubit() : super(LoginPageState());

  void navigateToSignUp(){
      emit(SignUpPageState());
  }
  void navigateToLogin(){
    emit (LoginPageState());
  }

  void navigateToProjectDetails(){
    emit(ProjectDetailsPageState());
  }
  void navigateToProjectsPage(){
    emit(ProjectPageState());
  }

}
