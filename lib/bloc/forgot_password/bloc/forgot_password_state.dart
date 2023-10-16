part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState extends Equatable {
  List<Object> get props =>[];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class SubmittingEmailState extends ForgotPasswordState{}

final class SubmitEmailSuccess extends ForgotPasswordState{
  final String successMessage;
  
   SubmitEmailSuccess(this.successMessage);

  List<Object> get props =>[successMessage];
}

final class SubmitEmailFailure extends ForgotPasswordState{
  SubmitEmailFailure(this.error);
  final String error;

  List<Object> get props =>[error];
}