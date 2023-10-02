import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/update_image/bloc/pick_image_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/user_projects_bloc.dart';
import 'package:nca/repos/project_repository.dart';
import 'package:image_picker/image_picker.dart';

class AddImageDialog extends StatelessWidget {
  final String token;
  final String projectId;
  final BuildContext projectContext;

  const AddImageDialog(
      {required this.token,
      required this.projectId,
      required this.projectContext});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(ProjectImageRepo()),
      child: BlocListener<ImageBloc, ImageState>(
        listener: (context, state) {
          if (state is ImageSavingComplete) {
            showDialog(
              context: context,
              builder: (BuildContext dialogcontext) {
                return AlertDialog(
                  title: Center(
                    child: Text(
                      'Image Saved successfully',
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
                          BlocProvider.of<UserProjectsBloc>(projectContext)
                              .add(LoadProjectsEvent(token: token));
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
          if (state is ImageSavingFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Image Saving Failed!',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  content: Text('There was an error while saving the image.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageSaving) {
              return Align(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        "Updating image",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

            if (state is ImagePicked) {
              return AlertDialog(
                content: Container(
                  // width: 300,
                  // height: 100,
                  child: Image.file(
                    File(state.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      context.read<ImageBloc>().add(SaveImageButtonClicked(
                          file: XFile(state.imagePath), token, projectId));

                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
            // The Default dialog
            return AlertDialog(title: Text('Add Image'), actions: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        BlocProvider.of<ImageBloc>(context)
                            .add(UseCameraImage());
                      },
                      child: Text("Use Camera"),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      BlocProvider.of<ImageBloc>(context)
                          .add(PickGalleryImage());
                    },
                    child: Text("From gallery"),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
