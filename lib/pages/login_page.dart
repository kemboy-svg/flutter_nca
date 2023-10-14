import 'package:flutter/material.dart';
import 'package:nca/bloc/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/user_projects_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/pages/forgotpassword_page.dart';
import 'package:nca/pages/projects_page.dart';
import 'package:nca/pages/signup_page.dart';
import 'package:nca/repos/user_repository.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(LoginRepository()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginNOSuccess){
              ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                     SnackBar(
                      
                      content: Center(
                        child: Text('Incorrect credentials, Please check your login details')
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
            }
            if (state is LoginFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    state.serverResponse.status,
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text(state.serverResponse.message),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: BlocBuilder<SwitchPageCubit, SwitchPageState>(
            builder: (context, state) {
              if (state is SignUpPageState) {
                return SignUpPage();
              }
              if(state is ForgotPasswordPageState){
                return ForgotPasswordPage();
              }
              return BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccess) {
                    context.read<UserProjectsBloc>().add(LoadProjectsEvent(token:state.user.token));
 
                    return ProjectPage();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 40),
                            child: Image(
                              image: AssetImage('images/nca-logo.png'),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Container(
                                  width: 4,
                                  height: 50,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          form(
                              usernameController: _usernameController,
                              passwordController: _passwordController),
                          SizedBox(
                            height: 50,
                          ),
                          _bottomItems(),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}






class form extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const form({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<form> {
  bool isButtonEnabled = false;
  int minPasswordLength = 6;
  int minUsernameLength = 4;

  @override
  void initState() {
    super.initState();

    widget.usernameController.addListener(updateButtonState);
    widget.passwordController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    widget.usernameController.removeListener(updateButtonState);
    widget.passwordController.removeListener(updateButtonState);
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      final username = widget.usernameController.text;
      final password = widget.passwordController.text;

      isButtonEnabled = username.isNotEmpty &&
          username.length >= minUsernameLength &&
          password.isNotEmpty &&
          password.length >= minPasswordLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    // Wrap the TextFormField widgets with a SingleChildScrollView
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: widget.usernameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            
            SizedBox(height: 40),
            TextFormField(
              controller: widget.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 60),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator(
                    color: Colors.blue,
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: isButtonEnabled
                        ? () {
                            loginBloc.add(
                              LoginButtonPressed(
                                username: widget.usernameController.text,
                                password: widget.passwordController.text,
                              ),
                            );
                          }
                        : null,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _bottomItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            context.read<SwitchPageCubit>().navigateToSignUp();
          },
          child: Text(
            "Create Account",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () {
             context.read<SwitchPageCubit>().navigateToForgotpassword();
          },
          child: Text(
            "Forgot password?",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
