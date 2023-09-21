import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';
import 'package:nca/pages/details_project_page.dart';
import 'package:nca/pages/widgets/add_project_dialog.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchPageCubit, SwitchPageState>(
      builder: (context, state) {
        if (state is ProjectDetailsPageState){
          return DetailsPage();
        }
        return Scaffold(
          backgroundColor: Image.asset('images/Contours.png').color,
          appBar: AppBar(
            title: Text(
              'Hello Admin',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Image.asset('images/settings_icon.png'),
                  onPressed: () {
                    print('Settings icon pressed');
                  },
                  iconSize: 15,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Projects",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 239, 239),
                      image: DecorationImage(
                        image: AssetImage('images/Contours.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ProjectBanner();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ProjectDialog(),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      label: Text(
                        "New project",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        elevation: MaterialStateProperty.all<double>(8.0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProjectBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GestureDetector(
        onTap: () {
          context.read<SwitchPageCubit>().navigateToProjectDetails();
          print("Gesture pressed");
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 10,
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
                "Business Center",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.black),
                title: Text(
                  'Coordinates',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
