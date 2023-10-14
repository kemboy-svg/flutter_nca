import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/bloc/user_projects/bloc/project_details_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/pages/widgets/contracter_widget.dart';
import 'package:nca/pages/widgets/documents_widget.dart';
import 'package:nca/pages/widgets/Inspection_widget.dart';


// ignore: must_be_immutable
class ProjectDetailsPage extends StatelessWidget {
  String projectName = "";
  String coordinates="";
  String imageUrl="";
  String ProjectId="";

  ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        if (state is ProjectDetailsLoaded) {
          projectName = state.projectDetails.projectName;
          
        }
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 239, 239),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<SwitchPageCubit>().navigateToProjectsPage();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              projectName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            // final projectDetails=context.read<ProjectDetailsBloc>().state;
            child: Column(
              children: [
                BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
                  builder: (context, state) {
                    if (state is ProjectDetailsLoaded) {
                     final String ? imageUrl = state.projectDetails.picture;
                      final coordinates = state.projectDetails.coordinates;
                       final projectName = state.projectDetails.projectName;
                      return ProjectBanner(
                        coordinates: coordinates,
                        imageUrl: imageUrl,
                        projectName: projectName,
                      );
                      
                    }
                    if (state is ProjectDetailsLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DocumentsWidget(),
                SizedBox(
                  height: 20,
                ),
                ContracterWidget(),
                SizedBox(
                  height: 8,
                ),
                InspectionWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ProjectBanner extends StatelessWidget {
  String coordinates;
  String projectName;
  final String? imageUrl;

  ProjectBanner(
      {super.key,
      required this.coordinates,
      this.imageUrl,
      required this.projectName});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 253, 253, 253),
                  spreadRadius: 20,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PageView.builder(itemBuilder: (context, Index) {
                    return ClipRect(
                      
                      child: Image.network(
                        imageUrl ??
                            "https://media.istockphoto.com/id/170616024/photo/concrete-highrise-construction-site.jpg?s=612x612&w=0&k=20&c=7-lJj9c_WVakkqoM6WTCNu9Q-E7bV6goRzS0NBnKsCc=",
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  projectName,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.black),
                  title: Text(
                    'Coordinates${coordinates}',
                    // 'Coordinates',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status:',
                  style: TextStyle(
                    color: Colors.blue,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,),
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          height: 8,
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text("0/100",style: TextStyle(color: Colors.orange),),
                        )
                      ],
                    ),
                  ),
              Text('Awaiting site inspection'),
            ],
          ),
        )
      ],
    );
  }
}
