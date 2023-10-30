import 'package:flutter/material.dart';
import 'package:nca/bloc/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is SubmitEmailFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                      'Email submission failed, please check your email and try again'),
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state is SubmitEmailSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext dialogcontext) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    'Password reset link has been sent to your email, Use the link to reset your password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      try {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pop(); // This will close the AddProjectDialog

                        //  context.read<SwitchPageCubit>().navigateToProjectsPage();
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.read<SwitchPageCubit>().navigateToLogin();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue,
              title: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ForgotPasswordForm(),
          );
        },
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPassBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("To reset your password, Please enter your email address"),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if (state is SubmittingEmailState) {
                return CircularProgressIndicator(
                  color: Colors.blue,
                );
              }

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  forgotPassBloc
                      .add(onTappedSubmitButton(Email: emailController.text));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
