part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object>get props => [];
}

 class SignUpInitial extends SignUpState {}

class SigningUp extends SignUpState{}

class SignedUpFailure  extends SignUpState{
  final String error;
  const  SignedUpFailure({required this.error});

  @override
  List<Object>get props => [error];
}

class SignedUpSuccess extends SignUpState{}

