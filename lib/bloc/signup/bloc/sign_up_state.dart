part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SigningUp extends SignUpState {}

class SignedUpFailure extends SignUpState {
  final ServerResponse serverResponse;

  SignedUpFailure({required this.serverResponse});


  @override
  List<Object> get props => [serverResponse];
}

class SignedUpSuccess extends SignUpState {}
