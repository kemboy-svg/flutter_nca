part of 'get_documents_bloc.dart';

@immutable
sealed class GetDocumentsEvent extends Equatable {
  const GetDocumentsEvent();
}

class LoadDocumentsEvent extends GetDocumentsEvent{
 final token;
 final projectId;

 LoadDocumentsEvent({
 required this.token,
 required this.projectId,
 });
 
  @override
  List<Object> get props =>[token, projectId];
}
