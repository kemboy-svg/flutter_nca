part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent extends Equatable {}
final class onTappedSubmitButton extends ForgotPasswordEvent {
final String Email;

  onTappedSubmitButton({required this.Email});
  List<Object> get props =>[Email];

}
