part of 'coordinates_bloc.dart';

@immutable
sealed class CoordinatesState extends Equatable {

  @override
  List<Object> get props => [];
}

final class CoordinatesInitial extends CoordinatesState {}

final class LocationServiceDisabled extends CoordinatesState{}

final class PermissionDenied extends CoordinatesState{}

final class PermissionDeniedForever extends CoordinatesState{}  

final class coordinatesPicked extends CoordinatesState{
  final Position coordinates;

  coordinatesPicked({required this.coordinates});

  List<Object>get props => [];
}
final class coordinatesPicking extends CoordinatesState{} 
final class coordinatesError extends CoordinatesState{
  final String error;

  coordinatesError({required this.error});
  @override 

  List<Object> get props => [];
}
