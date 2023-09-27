import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/project_model.dart';
import 'package:nca/repos/project_repository.dart';

part 'user_projects_event.dart';
part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
   final UserProjectsRepo _userprojectsRepo;

  UserProjectsBloc(this._userprojectsRepo) : super(ProjectsLoading()) {
    on<LoadProjectsEvent>((event, emit) async{
     try {
       emit(ProjectsLoading());
           await Future.delayed(Duration(seconds: 5));
      final projects =await _userprojectsRepo.getProjects();
      
       emit(ProjectsLoaded(projects));
       print(projects);
     } catch (e) {

       emit(ProjectsError(e.toString()));
       print("some error ${e.toString()}");
     }
    });
  }
}
