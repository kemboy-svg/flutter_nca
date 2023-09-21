part of 'coordinates_bloc.dart';

@immutable
sealed class  CoordinatesEvent extends Equatable {
   @override
  List<Object> get props => [];
}



class pickCoordinateEvent extends CoordinatesEvent{}
