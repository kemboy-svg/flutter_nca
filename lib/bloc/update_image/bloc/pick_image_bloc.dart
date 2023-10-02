import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/repos/project_repository.dart';

part 'pick_image_event.dart';
part 'pick_image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _picker = ImagePicker();
  final ProjectImageRepo _projectimageRepo;

  ImageBloc(this._projectimageRepo) : super(ImageInitial()) {
    on<PickGalleryImage>((event, emit) async {
      emit(ImageInitial());
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      _processPickedImage(pickedFile, emit);
    });

    on<UseCameraImage>((event, emit) async {
      emit(ImageInitial());
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      _processPickedImage(pickedFile, emit);
    });

    on<SaveImageButtonClicked>((event, emit)async {
      try {
        emit(ImageSaving());
        final success = await _projectimageRepo.updateImage(
          event.projectId,
           event.token,
            File(event._file.path), 
            );
           print("file${ File(event._file.path)}");

            if (success==true){
              emit(ImageSavingComplete());
            }
            else{
              emit(ImageSavingFailure(error: "error while updating the image"));
            }
      } catch (e,stacktrace) {
        print('error${e.toString()},${stacktrace}');
      }
    });
  }

  void _processPickedImage(XFile? pickedFile, Emitter<ImageState> emit) {
    if (pickedFile != null) {
      emit(
        ImagePicked(pickedFile.path),
      );
      // print("This is your file path");
      // print(pickedFile.path);
    } else {
      // The user does not have a smartphone !!.
    }
  }
}
