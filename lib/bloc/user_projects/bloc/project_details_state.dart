part of 'project_details_bloc.dart';

@immutable
sealed class ProjectDetailsState extends Equatable {}

final class ProjectDetailsInitial extends ProjectDetailsState {
  
  
   @override
  List<Object>get props => [];
}
final class ProjectDetailsLoading extends ProjectDetailsState{


   @override
  List<Object>get props => [];
}

final class ProjectDetailsLoaded extends ProjectDetailsState{
final ProjectDetailmodel projectDetails;


ProjectDetailsLoaded({required this.projectDetails});
 

   @override
  List<Object>get props => [projectDetails];
}


