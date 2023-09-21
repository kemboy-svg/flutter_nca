import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';

part 'pick_image_event.dart';
part 'pick_image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _picker = ImagePicker();

  ImageBloc() : super(ImageInitial()) {
    on<PickImage>((event, emit) async{
  emit (ImageInitial());
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit (ImagePicked(pickedFile.path));
        print("This is your file path");
        print(pickedFile.path);
      }
    });
  }
}

// class PickImageBloc extends Bloc<PickImageEvent, PickImageState> {
//   PickImageBloc() : super(PickImageInitial());

  
//   @override
//   Stream<PickImageState> mapEventToState(PickImageEvent event) async* {
//     if (event is SelectImageEvent) {
//       yield PickedImageLoading();
//       try {
//         final ImagePicker imagePicker = ImagePicker();
//         final XFile? image = await imagePicker.pickImage(
//           source: ImageSource.gallery, 
//         );

//         if (image != null) {
//           yield PickedImageSuccess(image.path);
//         } else {
//           yield PickedImageError('Image selection canceled');
//         }
//       } catch (e) {
//         yield PickedImageError(e.toString());
//         print("error while picking the image");
//       }
//     }
//   }
// }
