part of 'user_projects_bloc.dart';

@immutable
sealed class UserProjectsState extends Equatable{}

final class UserProjectsInitial extends UserProjectsState {
  
  @override
  List<Object>get props => [];
}

final class ProjectsLoading extends UserProjectsState{
   @override
  List<Object>get props => [];
}

final class ProjectsLoaded extends UserProjectsState{
  ProjectsLoaded(this.projects);
  final List<ProjectModel> projects;


   @override
  List<Object>get props => [projects];
}

final class ProjectsError extends UserProjectsState{
  ProjectsError(this.error);

  final String error;

  @override
  List<Object> get props =>[error];
}


