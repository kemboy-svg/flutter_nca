part of 'switch_page_cubit.dart';

@immutable
sealed class SwitchPageState {}

final class LoginPageState extends SwitchPageState {}

final class SignUpPageState extends SwitchPageState{}

final class ProjectDetailsPageState extends SwitchPageState{}
  
  

final class ProjectPageState extends SwitchPageState{}
 
 final class LoadingState extends SwitchPageState{}
 final class ForgotPasswordPageState extends SwitchPageState{}
 final class LoginScreen extends SwitchPageState{}