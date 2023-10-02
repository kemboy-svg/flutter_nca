part of 'pick_image_bloc.dart';

@immutable
sealed class PickImageEvent {}

class ImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PickGalleryImage extends ImageEvent {}

class UseCameraImage extends ImageEvent {}

class SaveImageButtonClicked extends ImageEvent {
  final XFile _file;
  final String token;
  final String projectId;

  SaveImageButtonClicked(this.token, this.projectId, {required XFile file}) : _file = file;
  @override
  List<Object> get props =>[_file,token,projectId];

}
