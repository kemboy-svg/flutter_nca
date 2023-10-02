

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nca/repos/project_repository.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final AddProjectRepo _addProjectRepo;

  ProjectBloc(this._addProjectRepo) : super(ProjectInitial()) {
    on<ProjectSaveButtonClicked>((event, emit) async {
      emit(ProjectSubmitting());
      try {
        final success = await _addProjectRepo.addNewProject(
          event.ProjectName,
          event.coordinatesString,
          event.token,
          // event.Image,
          

        );
        
       
        if (success){
          emit(ProjectSubmissionSuccess());
          
        }
        else{
          emit(ProjectSubmissionFailure(error: "Failed to save"),);
        }
        //  print('nameof ${event.ProjectName}');
        // // print(event.Image);
        // print(event.coordinates);
        
      } catch (e) {
        emit(ProjectSubmissionFailure(error:"An error occured while submitting project"));
      }
    });

    
  }
}
