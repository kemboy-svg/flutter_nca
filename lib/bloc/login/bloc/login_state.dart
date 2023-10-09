part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final ServerResponse serverResponse;

  const LoginFailure({required this.serverResponse});

  @override
  List<Object> get props => [serverResponse];
}

class LoginSuccess extends LoginState {
  LoginSuccess(this.user);

  final UserDetailsModel user;
  @override
  List<Object> get props => [user];
}

class LoginNOSuccess extends LoginState {
  final String error;

  LoginNOSuccess({required this.error});
  @override
  List<Object> get props => [error];
}
