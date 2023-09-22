import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nca/cubit/switch_page_cubit.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<SwitchPageCubit>().navigateToProjectsPage();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Business Center",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProjectBanner(),
            SizedBox(
              height: 20,
            ),
            _projectSteps(),
          ],
        ),
      ),
    );
  }
}

class _ProjectBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
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
    );
  }
}

class _projectSteps extends StatelessWidget {
  // const _projectSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Stepper(
              currentStep: 0,
              steps: [
                Step(
                  title: Text(
                    "Documents",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    children: [
                      Text("Content for Documents step"),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Contractor",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    children: [
                      Text("Content for Contractor step"),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Ground Breaking",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    children: [
                      // Add your content for the "Ground Breaking" step here
                      // For example, you can add a Text widget with relevant content.
                      Text("Content for Ground Breaking step"),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Final Inspection",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    children: [
                      // Add your content for the "Ground Breaking" step here
                      // For example, you can add a Text widget with relevant content.
                      Text("Content for Ground Breaking step"),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Project Closure",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    children: [
                      // Add your content for the "Ground Breaking" step here
                      // For example, you can add a Text widget with relevant content.
                      Text("Content for Ground Breaking step"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
