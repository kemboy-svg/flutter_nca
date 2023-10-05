import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/login/bloc/login_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/delete_project_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/project_details_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/user_projects_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/data/project_model.dart';
import 'package:nca/pages/project_details_page.dart';
import 'package:nca/pages/widgets/add_image_dialog.dart';
import 'package:nca/pages/widgets/add_newproject_dialog.dart';

// import 'package:geolocator/geolocator.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = context.read<LoginBloc>().state;
    String userName = "";
    String token = "";
   

    if (loginState is LoginSuccess) {
      userName = loginState.user.firstName;
      token = loginState.user.token;
    }
    return BlocBuilder<SwitchPageCubit, SwitchPageState>(
      builder: (context, state) {
       
        if (state is ProjectDetailsPageState) {
          //  final projectState = context.read<UserProjectsBloc>().state;

          
        //  context.read<UserProjectsBloc>().add(LoadProjectsEvent(token:state.token));
          return ProjectDetailsPage();
        }
        if (state is LoadingState) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ));
        }
       
        return Scaffold(
          backgroundColor: Image.asset('images/Contours.png').color,
          appBar: AppBar(
            title: Text(
              'Hello $userName',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Image.asset('images/settings_icon.png'),
                  onPressed: () {
                    BlocProvider.of<SwitchPageCubit>(context).navigateToLogin();
                    // context.read<SwitchPageCubit>().navigateToLogin();
                  },
                  iconSize: 15,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Projects",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 239, 239),
                      image: DecorationImage(
                        image: AssetImage('images/Contours.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
                      builder: (context, state) {
                        if (state is ProjectsLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is ProjectsLoaded) {
                          List<ProjectModel> projectList = state.projects;

                          return ListView.builder(
                            itemCount: projectList.length,
                            itemBuilder: (context, index) {
                              return ProjectBanner(
                                projectName: projectList[index].projectName,
                                imageUrl: projectList[index].picture,
                                coordinates: projectList[index].coordinates,
                                Id: projectList[index].projectId,
                                token: token,
                              );
                            },
                          );
                        }
                        return Center(
                            child: Text('No projects registered yet'));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final projectContext = context;

                        // print('Current context${context}');
                        showDialog(
                          context:
                              projectContext, // Use the context from the current widget

                          builder: (BuildContext context) {
                            // print('Dialog context${context}');
                            return AddProjectDialog(
                                token: token, projectContext: projectContext);
                          },
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        "New project",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        elevation: MaterialStateProperty.all<double>(8.0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProjectBanner extends StatelessWidget {
  final String projectName;
  final String? imageUrl;
  final String coordinates;
  final String Id;
  final String token;

  ProjectBanner({
    super.key,
    required this.projectName,
    this.imageUrl,
    required this.coordinates,
    required this.Id,
    required this.token,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GestureDetector(
        
        onTap: () {
          context.read<SwitchPageCubit>().navigateToProjectDetails();
          context.read<ProjectDetailsBloc>().add(LoadProjectDetailsEvent(token: token,projectId: Id));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 10,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PageView.builder(itemBuilder: (context, Index) {
                  return ClipRect(
                      child: Image.network(
                    imageUrl ??
                        "https://media.istockphoto.com/id/170616024/photo/concrete-highrise-construction-site.jpg?s=612x612&w=0&k=20&c=7-lJj9c_WVakkqoM6WTCNu9Q-E7bV6goRzS0NBnKsCc=",
                    fit: BoxFit.fitWidth,
                  ));
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                // 'Business center',
                projectName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.black),
                title: Text(
                  // 'Coordinates',
                  coordinates,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      final projectContext = context;

                      showDialog(
                        context: projectContext,
                        builder: (BuildContext context) {
                          return AddImageDialog(
                            token: token,
                            projectId: Id,
                            projectContext: projectContext,
                          );
                        },
                      );
                    },
                    child: Text(
                      'Update Image',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // final theProjectContext = context;
                      print('current context${context}');

                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          print('dialog context${dialogContext}');
                          return AlertDialog(
                            title: Text('Confirm'),
                            content: Text(
                              'Are you sure you want to delete the ${projectName} project?',
                              style: TextStyle(color: Colors.red),
                            ),
                            actions: [
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  try {
                                    BlocProvider.of<DeleteProjectBloc>(context)
                                        .add(onDeleteEvent(
                                            projectId: Id, token: token));

                                    BlocProvider.of<UserProjectsBloc>(context)
                                        .add(LoadProjectsEvent(token: token));

                                    BlocProvider.of<UserProjectsBloc>(context)
                                        .add(LoadProjectsEvent(token: token));

                                    Navigator.of(dialogContext).pop();
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
