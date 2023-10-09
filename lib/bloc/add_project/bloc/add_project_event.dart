part of 'add_project_bloc.dart';

@immutable
sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}


class ProjectSaveButtonClicked extends ProjectEvent {
  // final File Image;
  final String ProjectName;
   final Position coordinates;
   final token;
    final String coordinatesString;

  ProjectSaveButtonClicked({
      //  required this.Image,
      required this.ProjectName,
       required this.coordinates,
       required this.token, 
      }): coordinatesString = 'Latitude: ${coordinates.latitude}, Longitude: ${coordinates.longitude}';

  @override
  List<Object> get props => [ ProjectName,coordinatesString,token];
}
