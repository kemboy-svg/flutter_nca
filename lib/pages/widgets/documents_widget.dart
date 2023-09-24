import 'package:flutter/material.dart';

class DocumentsWidget extends StatefulWidget {
  @override
  _DocumentsWidgetState createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> {
  bool _showContent = false;
  final AssetImage arrowUpImage = AssetImage('images/arrow_up.png');
  final AssetImage arrowDownImage = AssetImage('images/arrow_down.png');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Documents',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_showContent)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.announcement_rounded,
                              color: Colors.blue,
                            ),
                            Text(
                              'Please provide the following details in order\n to register your project at NCA.',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text("NEMA"),
                            SizedBox(
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Choose file'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("NEMA"),
                            SizedBox(
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Choose file'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("NEMA"),
                            SizedBox(
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Choose file'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("NEMA"),
                            SizedBox(
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Choose file'),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
              icon: _showContent
                  ? ImageIcon(arrowUpImage)
                  : ImageIcon(arrowDownImage),
            ),
          ],
        ),
      ],
    );
  }
}
