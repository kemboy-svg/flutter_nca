part of 'add_project_bloc.dart';

@immutable
sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}


class ProjectSaveButtonClicked extends ProjectEvent {
  final File Image;
  final String ProjectName;
   final Position coordinates;

  ProjectSaveButtonClicked({
      required this.Image,
      required this.ProjectName,
       required this.coordinates
      });

  @override
  List<Object> get props => [ ProjectName,coordinates];
}
