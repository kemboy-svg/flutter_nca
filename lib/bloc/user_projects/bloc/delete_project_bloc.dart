import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/repos/project_repository.dart';

part 'delete_project_event.dart';
part 'delete_project_state.dart';

class DeleteProjectBloc extends Bloc<DeleteProjectEvent, DeleteProjectState> {
  final DeleteProjectRepo _deleteProjectRepo;

  DeleteProjectBloc(this._deleteProjectRepo) : super(DeleteProjectInitial()) {
    on<onDeleteEvent>((event, emit) async{
      try {
        emit(DeleteProjectLoading());
        final success=await _deleteProjectRepo.deleteProject(
          event.projectId,
          event.token,
          
        );
        if (success==true){
          emit(ProjectDeleted());
        }
        else{
          // print('deleting error');
          emit(ProjectDeleteError(error: 'An error occured'));
        }
      } catch (e) {
        print( "Deleting error${e.toString()}");
        emit(ProjectDeleteError(error: e.toString()));
      }
    });
  }
}
