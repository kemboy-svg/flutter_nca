import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/signup/bloc/sign_up_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/repos/user_repository.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SignUpBloc(SignUpRepo()),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignedUpFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                     SnackBar(
                      
                      content: Center(
                        child: Text('${state.serverResponse.status}\n${state.serverResponse.message}')
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
              }

              if (state is SignedUpSuccess) {
                // final signState= context.read<SignUpBloc>().state;
                final projectcontext = context;
              
                print("current context${context}");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    print("Dialog context${context}");
                    
                    return AlertDialog(
                      title: Text("Signed Up Successful"),
                      content: Text('You can proceed to login.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            //  Navigator.of(context).pop();
                            //  context.read<SwitchPageCubit>().navigateToLogin();
                            BlocProvider.of<SwitchPageCubit>(projectcontext)
                                .navigateToLogin();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: BlocBuilder<SwitchPageCubit, SwitchPageState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        context.read<SwitchPageCubit>().navigateToLogin();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Toptext(),
                        SizedBox(
                          height: 20,
                        ),
                        SignUpForm(
                          firstNameController: _firstnameController,
                          lastNameController: _lastnameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          passwordController: _passwordController,
                          confpasswordController: _confpasswordController,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Toptext extends StatelessWidget {
  const Toptext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55,
                width: 3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create an",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  Text(
                    "Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confpasswordController;

  SignUpForm({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confpasswordController,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isButtonEnabled = false;
  int minPassword = 6;
  String _passwordErrorMessage = '';
  int minPhone = 10;
  int minName = 3;
  String _passwordMessage = '';

  @override
  void initState() {
    super.initState();

    widget.firstNameController.addListener(updateButtonState);
    widget.lastNameController.addListener(updateButtonState);
    widget.emailController.addListener(updateButtonState);
    widget.phoneController.addListener(updateButtonState);
    widget.passwordController.addListener(updateButtonState);
    widget.confpasswordController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    widget.firstNameController.removeListener(updateButtonState);
    widget.lastNameController.removeListener(updateButtonState);
    widget.emailController.removeListener(updateButtonState);
    widget.phoneController.removeListener(updateButtonState);
    widget.passwordController.removeListener(updateButtonState);
    widget.confpasswordController.removeListener(updateButtonState);

    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      final firstname = widget.firstNameController.text;
      final lastname = widget.lastNameController.text;
      final email = widget.emailController.text;
      final phone = widget.phoneController.text;
      final password = widget.passwordController.text;
      final confpassword = widget.confpasswordController.text;

      _isButtonEnabled = firstname.length >= minName &&
          lastname.length >= minName &&
          email.isNotEmpty &&
          phone.length >= 10 &&
          password.length >= minPassword &&
          password == confpassword &&
          confpassword.isNotEmpty;

      if (password.length < minPassword && password.length > 0) {
        _passwordMessage = 'Password should be at least 6 characters long';
      } else {
        _passwordMessage = '';
      }

      if (password != confpassword) {
        _passwordErrorMessage = 'Ooh buddy make sure you match the password';
      } else {
        _passwordErrorMessage = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final signupBloc = BlocProvider.of<SignUpBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.firstNameController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelText: 'First Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.lastNameController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelText: 'Last Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.emailController,
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
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.phoneController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelText: 'Phone No',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Phone number must contain only digits';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.announcement_rounded,
                color: Colors.blue,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Provide a valid phone number of 10 digits',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: _passwordMessage.isNotEmpty ? _passwordMessage : null,
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
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.confpasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              errorText: _passwordErrorMessage.isNotEmpty
                  ? _passwordErrorMessage
                  : null,
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
            onChanged: (_) {
              _isButtonEnabled;
            },
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SigningUp) {
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
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _isButtonEnabled
                        ? () {
                            signupBloc.add(
                              SignUpButtonTapped(
                                  firstname: widget.firstNameController.text,
                                  lastname: widget.lastNameController.text,
                                  email: widget.emailController.text,
                                  phone: widget.phoneController.text,
                                  password: widget.passwordController.text,
                                  confPassword:
                                      widget.confpasswordController.text),
                            );
                          }
                        : null);
              }
            },
          ),
        ],
      ),
    );
  }
}
