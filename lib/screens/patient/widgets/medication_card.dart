import 'package:flutter/material.dart';
class MedicationCard extends StatefulWidget {
  final String medicationId;
  final String medicationName;
  final String time;
  final bool isTaken;
  final VoidCallback onIconPressed;

  const MedicationCard({
    super.key,
    required this.medicationId,
    required this.medicationName,
    required this.time,
    required this.isTaken,
    required this.onIconPressed,
  });

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  late bool _isTaken;

  @override
  void initState() {
    _isTaken = widget.isTaken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 60,
              color: _isTaken ? Color(0xFFBEE3BA) : Colors.red,
            ),
            SizedBox(width: 10),
            Icon(
              Icons.medication,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.medicationName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: _isTaken
                  ? null
                  : () {
                      widget.onIconPressed(); // Call the callback
                      setState(() {
                        _isTaken = true; // Update local state
                      });
                    },
              child: Icon(
                _isTaken ? Icons.check_circle : Icons.check_circle_outline,
                color: _isTaken ? Color(0xFFBEE3BA) : Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
