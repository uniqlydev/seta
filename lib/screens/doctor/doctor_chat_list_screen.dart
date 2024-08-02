import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/screens/doctor/doctor_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'doctor_chat.dart';

class DoctorChatListScreen extends StatefulWidget {
  const DoctorChatListScreen({super.key});

  @override
  _DoctorChatListScreenState createState() => _DoctorChatListScreenState();
}

class _DoctorChatListScreenState extends State<DoctorChatListScreen> {
  int _selectedIndex = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> patientUsernames = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

        List<String> fetchedPatientUsernames = snapshot.docs.map((doc) => doc.id).toList();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/inbox-doctor');
          },
        ),
        title: Center(
          child: Text(
            'Patients List',
            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
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

    // Limit the number of document IDs to 10 due to Firestore constraints
    List<String> limitedPatientUsernames = patientUsernames.take(10).toList();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('patients')
          .where(FieldPath.documentId, whereIn: limitedPatientUsernames)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error fetching patients: ${snapshot.error}');
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
            return _buildUserListItem(doc);
          }).toList(),
        );
      },
    );
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