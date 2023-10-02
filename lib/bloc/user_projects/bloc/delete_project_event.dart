part of 'delete_project_bloc.dart';

@immutable
sealed class DeleteProjectEvent extends Equatable {}

final class onDeleteEvent extends DeleteProjectEvent{
  final projectId;
  final token;

  onDeleteEvent({
    required this.projectId,
    required this.token
  });

  @override
  List <Object> get props =>[projectId,token];
}
