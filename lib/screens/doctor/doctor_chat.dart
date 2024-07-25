import 'package:flutter/material.dart';

class DoctorChat extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const DoctorChat({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
    });

  @override
  State<DoctorChat> createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text(widget.receiverUserEmail)),
    );
  }
}