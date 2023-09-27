part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

    @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends LoginState {
LoginSuccess(this.user);

final UserDetailsModel user;
   @override
  List<Object> get props => [user];
  
}
