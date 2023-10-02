part of 'delete_project_bloc.dart';

@immutable
sealed class DeleteProjectState extends Equatable {}

final class DeleteProjectInitial extends DeleteProjectState {

  @override
  List <Object> get props =>[];
}
final class DeleteProjectLoading extends DeleteProjectState{


   @override
  List <Object> get props =>[];
}

final class ProjectDeleted extends DeleteProjectState{

    @override
  List <Object> get props =>[];
}
final class ProjectDeleteError extends DeleteProjectState{
  final String error;

  ProjectDeleteError({
    required this.error,
  });

  @override
  List <Object> get props =>[error];
}

