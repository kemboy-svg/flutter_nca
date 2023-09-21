part of 'pick_image_bloc.dart';

@immutable
sealed class ImageState extends Equatable {
   
  
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImagePicked extends ImageState {
  final String imagePath;

  ImagePicked(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}






