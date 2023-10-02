part of 'user_projects_bloc.dart';

@immutable
sealed class UserProjectsEvent extends Equatable {
  const UserProjectsEvent();
}

final class LoadProjectsEvent extends UserProjectsEvent{

final token;

LoadProjectsEvent({
  required this.token
});

  @override
  List<Object> get props =>[token];
}
