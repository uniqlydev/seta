import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/screens/doctor/doctor_nav_bar.dart';
import 'package:codingbryant/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'doctor_chat.dart';

class DoctorInboxScreen extends StatefulWidget {
  const DoctorInboxScreen({super.key});

  @override
  _DoctorInboxScreenState createState() => _DoctorInboxScreenState();
}

class _DoctorInboxScreenState extends State<DoctorInboxScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService(); // Create an instance of ChatService
  List<String> patientUsernames = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientUsernames();
  }

  Future<void> _fetchPatientUsernames() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.uid)
            .collection('patients')
            .get();

        List<String> fetchedPatientUsernames = snapshot.docs
            .map((doc) => doc.id)
            .toList();

        setState(() {
          patientUsernames = fetchedPatientUsernames;
        });
      } catch (e) {
        print('Error fetching patient usernames: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Inbox'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/list-doctor');
            },
          ),
        ],
      ),
      body: _buildUserList(),
      bottomNavigationBar: DoctorNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildUserList() {
    if (patientUsernames.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('patients')
          .where('uid', whereIn: patientUsernames)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching patients.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No patients found.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return FutureBuilder<bool>(
              future: _hasMessages(doc['uid']),
              builder: (context, AsyncSnapshot<bool> hasMessagesSnapshot) {
                if (hasMessagesSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (hasMessagesSnapshot.hasData && hasMessagesSnapshot.data!) {
                  return _buildUserListItem(doc);
                } else {
                  return Container();
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<bool> _hasMessages(String patientId) async {
    final user = _auth.currentUser;
    if (user != null) {
      List<String> ids = [user.uid, patientId];
      ids.sort();
      String chatRoomId = ids.join("_");

      QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .limit(1)
          .get();
      return messageSnapshot.docs.isNotEmpty;
    }
    return false;
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null || data['email'] == null || data['uid'] == null) {
      return Container(); // Return an empty container if data is null or incomplete
    }

    return ListTile(
      title: Text(data['email']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorChat(
              receiverUserEmail: data['email'],
              receiverUserID: data['uid'],
            ),
          ),
        );
      },
    );
  }
}
