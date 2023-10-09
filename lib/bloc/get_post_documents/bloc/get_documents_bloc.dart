import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:nca/data/project_model.dart';
import 'package:nca/repos/project_repository.dart';

part 'get_documents_event.dart';
part 'get_documents_state.dart';

class GetDocumentsBloc extends Bloc<GetDocumentsEvent, GetDocumentsState> {
  final ProjectsDocumentsRepo _projectsDocumentsRepo;

  GetDocumentsBloc(this._projectsDocumentsRepo) : super(GetDocumentsInitial()) {
    on<LoadDocumentsEvent>((event, emit) async {
      try {
        emit(DocumentsLoading());
        final response = await _projectsDocumentsRepo.getProjectDocuments(
         event.projectId, 
          event.token);

          if (response is ProjectDocumentsModel)
          emit(DocumentsLoaded(projectDocuments: response));
      } catch (e) {
        emit(GetDocumentsError(e.toString()));
      }
    });
  }
}
