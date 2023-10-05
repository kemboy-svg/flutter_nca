part of 'project_details_bloc.dart';

@immutable
sealed class  ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();
}

final class LoadProjectDetailsEvent extends  ProjectDetailsEvent{
  final token;
  final projectId;

 LoadProjectDetailsEvent({
  required this.token,
  required this.projectId
 }); 

 @override 
 List<Object> get props =>[token, projectId];
}
