import 'package:flutter/material.dart';

class InspectionWidget extends StatefulWidget {
  const InspectionWidget({super.key});

  @override
  _InspectionWidgetState createState() => _InspectionWidgetState();
}

class _InspectionWidgetState extends State<InspectionWidget> {
  bool _showContent = false;
  final AssetImage arrowUpImage = AssetImage('images/arrow_up.png');
  final AssetImage arrowDownImage = AssetImage('images/arrow_down.png');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '3. Inspection Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
          if (_showContent)
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
                  'Kindly note that our NCA officer will need to\n visit the intended construction site before\n excuvation begins',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
