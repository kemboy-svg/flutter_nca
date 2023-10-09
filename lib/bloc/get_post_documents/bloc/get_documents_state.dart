part of 'get_documents_bloc.dart';

@immutable
sealed class GetDocumentsState extends Equatable {}

final class GetDocumentsInitial extends GetDocumentsState {

  @override
   List<Object>get props => [];
}

final class DocumentsLoading extends GetDocumentsState{


    @override
   List<Object>get props => [];
}

final class DocumentsLoaded extends GetDocumentsState{
  final  ProjectDocumentsModel projectDocuments;

  DocumentsLoaded({
    required this.projectDocuments
  });

  @override
   List<Object>get props => [projectDocuments]; 
}

final class GetDocumentsError extends GetDocumentsState{
  final String error;

  GetDocumentsError(this.error);

  @override
  List<Object> get props =>[error];
}
