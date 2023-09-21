part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props =>[];
}

class SignUpButtonTapped extends SignUpEvent{
   
 final String firstname;
 final String lastname;
 final String email;
 final String phone;
 final String password;

   SignUpButtonTapped({
  required this.firstname,
  required this.lastname,
  required this.email,
  required this.phone,
  required this.password,
 });

 @override
 List<Object> get props=>[firstname,lastname,email,phone,password];
}