part of 'add_project_bloc.dart';

@immutable
sealed class ProjectState extends Equatable {
 
  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectState {
  

  @override
  List<Object> get props => [];
}

class ProjectSubmitting extends ProjectState {}

class ProjectSubmissionSuccess extends ProjectState{
  
  @override
  List<Object> get props => [];
}

class ProjectSubmissionFailure extends ProjectState{
  final String error;

  ProjectSubmissionFailure({required this.error});
  @override
  List<Object> get props =>[error];
}
