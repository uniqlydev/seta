import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/screens/patient/patient_chat.dart';
import 'package:codingbryant/screens/patient/patient_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientChatListScreen extends StatefulWidget {
  const PatientChatListScreen({super.key});

  @override
  _PatientChatListScreenState createState() => _PatientChatListScreenState();
}

class _PatientChatListScreenState extends State<PatientChatListScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> doctorIds = [];

  @override
  void initState() {
    super.initState();
    _fetchDoctorIds();
  }

  Future<void> _fetchDoctorIds() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .collection('prescriptions')
            .get();

        List<String> fetchedDoctorIds = snapshot.docs
            .map((doc) => doc['doctorId'] as String)
            .toList();

        setState(() {
          doctorIds = fetchedDoctorIds;
        });

        print('Fetched doctor IDs: $doctorIds'); // Debugging line
      } catch (e) {
        print('Error fetching doctor IDs: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/inbox-patient');
          },
        ),
      ),
      body: _buildUserList(),
      bottomNavigationBar: PatientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildUserList() {
    if (doctorIds.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where(FieldPath.documentId, whereIn: doctorIds)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching doctors.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No doctors found.'));
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
            builder: (context) => PatientChat(
              receiverUserEmail: data['email'],
              receiverUserID: data['uid'],
            ),
          ),
        );
      },
    );
  }
}
