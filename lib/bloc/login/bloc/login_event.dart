part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe; 

  const LoginButtonPressed({
    required this.username,
    required this.password,
    this.rememberMe=false});

  @override
  List<Object> get props => [username, password];
}
