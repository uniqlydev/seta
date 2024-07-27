import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/models/medication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  late List<MedicationModel> medications = [];
  late List<MedicationModel> filteredMedications = [];

  @override
  void initState() {
    super.initState();
    _fetchMedications();
  }

  void _fetchMedications() async {
    try {
      // Replace 'drugs' with your Firestore collection name
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('drugs').get();

      List<MedicationModel> fetchedMedications = snapshot.docs
          .map((doc) => MedicationModel.fromFirestore(doc))
          .toList();

      // Sort the medications alphabetically by the drug name
      fetchedMedications.sort((a, b) => a.drug.compareTo(b.drug));

      setState(() {
        medications = fetchedMedications;
        filteredMedications = medications; // Initialize filtered list with all medications
      });
    } catch (e) {
      print('Error fetching medications: $e');
    }
  }

  void _filterMedications(String query) {
    setState(() {
      filteredMedications = medications
          .where((medication) =>
              medication.drug.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    backgroundColor: Colors.blue,
                    expandedHeight: MediaQuery.of(context).size.height * 1 / 15, // Reduced height
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'MiMS Medication List',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate:
                                MedicationSearchDelegate(filteredMedications),
                          );
                        },
                      ),
                    ],
                  ),
                ];
              },
              body: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: filteredMedications.length,
                  itemBuilder: (context, index) {
                    MedicationModel medication = filteredMedications[index];
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(medication.drug),
                        subtitle: Text(medication.drugClass),
                        onTap: () {
                          // Pop up to show the remaining details of the medication
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(medication.drug),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Dosage: ${medication.dosage}'),
                                    Text('Side Effect: ${medication.sideEffect}'),
                                  ],
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
                                contentTextStyle: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        // Add more details or actions as needed
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is AuthFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class MedicationSearchDelegate extends SearchDelegate<MedicationModel> {
  final List<MedicationModel> medications;

  MedicationSearchDelegate(this.medications);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MedicationModel> results = medications
        .where((medication) =>
            medication.drug.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8, // Adjust the height as needed
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          MedicationModel medication = results[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text(medication.drug),
              subtitle: Text(medication.dosage),
              onTap: () {
                _showMedicationDetails(context, medication);
              },
            ),
          );
        },
      ),
    );
  }

  void _showMedicationDetails(
      BuildContext context, MedicationModel medication) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(medication.drug),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dosage: ${medication.dosage}'),
              Text('Side Effect: ${medication.sideEffect}'),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
          contentTextStyle: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MedicationModel> suggestions = medications
        .where((medication) =>
            medication.drug.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8, // Adjust the height as needed
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          MedicationModel medication = suggestions[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text(medication.drug),
              subtitle: Text(medication.drugClass),
              onTap: () {
                close(context, medication);
              },
            ),
          );
        },
      ),
    );
  }
}
