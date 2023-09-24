import 'package:flutter/material.dart';

class ContracterWidget extends StatefulWidget {
  @override
  _DocumentsWidgetState createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<ContracterWidget> {
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
              child: Text(
                '2. Contracter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(arrowDownImage),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(
              Icons.announcement_rounded,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Please attach your preferred contracter',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        TextFormField(
      decoration: InputDecoration(
        labelText: '777/B',
      ),    
        )
      ],
    );
  }
}
