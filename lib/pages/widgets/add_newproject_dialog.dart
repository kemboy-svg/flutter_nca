// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/add_project/bloc/add_project_bloc.dart';
import 'package:nca/bloc/pick_coordinates/bloc/coordinates_bloc.dart';
import 'package:nca/bloc/update_image/bloc/pick_image_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/user_projects_bloc.dart';
import 'package:nca/repos/project_repository.dart';

class AddProjectDialog extends StatelessWidget {
  String projectName = "";
  final String token;
  final BuildContext projectContext;

  AddProjectDialog({
    super.key,
    required this.token,
    required this.projectContext,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectBloc(AddProjectRepo()),
        ),
        BlocProvider(
          create: (context) => CoordinatesBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(ProjectImageRepo()),
        )
      ],
      child: BlocBuilder<CoordinatesBloc, CoordinatesState>(
        builder: (context, state) {
          // final coordinatesbloc = BlocProvider.of<CoordinatesBloc>(context);

          final addprojectbloc = BlocProvider.of<ProjectBloc>(context);
          Widget buttonWidget;

          if (state is LocationServiceDisabled) {
            buttonWidget = Text('Enable Location Services');
          } else if (state is PermissionDenied ||
              state is PermissionDeniedForever) {
            buttonWidget = Text('Grant Location Permission');
          } else if (state is coordinatesPicking) {
            buttonWidget = Center(
                child: Column(
              children: [
                CircularProgressIndicator(),
                Text(
                  "Getting location",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ));
          } else if (state is coordinatesPicked) {
            buttonWidget = Text(
                'Project Location:${(state).coordinates.latitude},${(state).coordinates.longitude}');
          } else {
            buttonWidget = Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.announcement_rounded,
                      color: Colors.blue,
                    ),
                    Text(
                      'Make sure you have picked\nlocation, Your current \nlocation will be saved as\nproject location',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    context.read<CoordinatesBloc>().add(pickCoordinateEvent());
                  },
                  child: Text(
                    'Pick Location',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }

          return BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: Text('Add Project'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Project Name'),
                        onChanged: (value) {
                          projectName = value;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      if (state is ImagePicked)
                        Container(
                          width: 300,
                          height: 100,
                          child: Image.file(
                            File(state.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: projectContext,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Add Image'),
                                  actions: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: TextButton(
                                            onPressed: () async {
                                              BlocProvider.of<ImageBloc>(
                                                      projectContext)
                                                  .add(UseCameraImage());
                                                  Navigator.of(context).pop();
                                            },
                                            child: Text("Use Camera"),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            BlocProvider.of<ImageBloc>(projectContext)
                                                .add(PickGalleryImage());
                                                Navigator.of(context).pop();
                                          },
                                          child: Text("From gallery"),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        child: Text(
                                          'Cancell',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                      ),
                                    ),
                                  ]);
                            },
                          );
                        },
                        child: Text("Choose Image"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CoordinatesBloc>()
                              .add(pickCoordinateEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 245, 246, 1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: buttonWidget,
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    BlocListener<ProjectBloc, ProjectState>(
                      listener: (context, state) {
                        if (state is ProjectSubmissionSuccess) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogcontext) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    'Project Saved successfully',
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
                                        BlocProvider.of<UserProjectsBloc>(
                                                projectContext)
                                            .add(LoadProjectsEvent(
                                                token: token));
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
                        } else if (state is ProjectSubmissionFailure) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Not saved Buddy!',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: Text('Hey!! Buddy there was an error'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: BlocBuilder<ProjectBloc, ProjectState>(
                        builder: (context, state) {
                          if (state is ProjectSubmitting)
                            return CircularProgressIndicator(
                              strokeWidth: 2.0,
                              backgroundColor: Colors.blue,
                            );
                          else {
                            return ElevatedButton(
                              onPressed: () {
                                final coordinatesState =
                                    context.read<CoordinatesBloc>().state;
                                // final imageState = state;

                                if (coordinatesState is coordinatesPicked &&
                                    // imageState is ImagePicked &&
                                    projectName.isNotEmpty) {
                                  addprojectbloc.add(
                                    ProjectSaveButtonClicked(
                                        ProjectName: projectName,
                                        // Image: File(imageState.imagePath),
                                        coordinates:
                                            coordinatesState.coordinates,
                                        token: token),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Not saved Buddy!',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: Text(
                                            'Hey!! Buddy make sure you have provided:\n 1.Project Name.\n 2.Provided an Image.\n 3.Confirm the project location\n and try again.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}


                         // TextButton(
                      //   onPressed: () {
                      //     coordinatesbloc.add(pickCoordinateEvent());
                      //   },
                      //   child: Text(buttonText),
                      // ),