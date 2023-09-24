
// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/add_project/bloc/add_project_bloc.dart';
import 'package:nca/bloc/image_picker/bloc/pick_image_bloc.dart';
import 'package:nca/bloc/pick_coordinates/bloc/coordinates_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/pages/projects_page.dart';
import 'package:nca/repos/project_repository.dart';

class ProjectDialog extends StatelessWidget {
 String projectName="";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
        BlocProvider(
          create: (context) => ProjectBloc(AddProjectRepo()),
        ),
        BlocProvider(
          create: (context) => CoordinatesBloc(),
        ),
         BlocProvider(
          create: (context) => SwitchPageCubit(),
        ),

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
          } else if (state is coordinatesPicked) {
            buttonWidget = Text(
                'Picked Coordinates:${(state).coordinates.latitude},${(state).coordinates.longitude}');
          } else {
            buttonWidget = Text(
              "Confirm this is the project's Location?",
              style: TextStyle(
                color: Colors.blue,
              ),
            );
          }

          return BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: Text('Add Project'),
                  content: Column(
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
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () async {
                            BlocProvider.of<ImageBloc>(context)
                                .add(PickImage());
                          },
                          child: Text(
                            'Pick Image',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                        ),
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
                            builder: (BuildContext context) {
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
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProjectPage()));
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
                            return BlocBuilder<ImageBloc, ImageState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    final coordinatesState =
                                        context.read<CoordinatesBloc>().state;
                                    final imageState =state;
                                      
                                    if (coordinatesState is coordinatesPicked &&
                                        imageState is ImagePicked &&
                                        projectName.isNotEmpty)
                                         {
                                      addprojectbloc.add(
                                        ProjectSaveButtonClicked(
                                          ProjectName: projectName,
                                          Image: File(imageState.imagePath),
                                          coordinates:
                                              coordinatesState.coordinates,
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Not saved Buddy!',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            content: Text(
                                                'Hey!! Buddy make your you have provided:\n 1.Project Name.\n 2.Provided an Image.\n 3.Confirm the project location\n Then try again.'),
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
                              },
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