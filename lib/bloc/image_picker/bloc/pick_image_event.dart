part of 'pick_image_bloc.dart';

@immutable
sealed class PickImageEvent {}

class ImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PickImage extends ImageEvent {}