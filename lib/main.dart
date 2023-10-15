import 'package:flutter/material.dart';
import 'package:nca/bloc/add_project/bloc/add_project_bloc.dart';
import 'package:nca/bloc/get_post_documents/bloc/get_documents_bloc.dart';
// import 'package:nca/bloc/image_picker/bloc/pick_image_bloc.dart';
import 'package:nca/bloc/login/bloc/login_bloc.dart';
// import 'package:nca/bloc/pick_coordinates/bloc/coordinates_bloc.dart';
import 'package:nca/bloc/signup/bloc/sign_up_bloc.dart';
import 'package:nca/bloc/update_image/bloc/pick_image_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/delete_project_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/project_details_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/user_projects_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/pages/auth/login_page.dart';
import 'package:nca/repos/project_repository.dart';
// import 'package:nca/pages/projects_page.dart';
import 'package:nca/repos/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NCA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(LoginRepository()),
          ),
          BlocProvider(
            create: (context) => SwitchPageCubit(),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(SignUpRepo()),
          ),
          BlocProvider(
            create: (context) => ProjectBloc(AddProjectRepo()),
          ),
          BlocProvider(
            create: (context) => ImageBloc(ProjectImageRepo()),
          ),
          BlocProvider(
            create: (context) => ProjectDetailsBloc(ProjectDetailsRepo()),
          ),
          
          
          BlocProvider(
            create: (context) => UserProjectsBloc(UserProjectsRepo(),),
          ),
           BlocProvider(
            create: (context) => DeleteProjectBloc(DeleteProjectRepo(),),
          ),
           BlocProvider(
            create: (context) => GetDocumentsBloc(ProjectsDocumentsRepo(),),
          ),
        ],
        child: LoginPage(),
      ),
    );
  }
}
