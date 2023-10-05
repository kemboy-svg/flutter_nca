import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/project_model.dart';
import 'package:nca/repos/project_repository.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final ProjectDetailsRepo _projectDetailsRepo;

  ProjectDetailsBloc(this._projectDetailsRepo) : super(ProjectDetailsInitial()) {
    on<LoadProjectDetailsEvent>((event, emit) async {
      try {
        emit(ProjectDetailsLoading());
        final response =  await _projectDetailsRepo.getProjectDetails(event.projectId, event.token);

        if(response is ProjectDetailmodel)
        
        emit(ProjectDetailsLoaded(projectDetails: response));
      } catch (e) {
        
      }
    });
  }
}
