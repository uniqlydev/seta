class PatientModel {
  final String id; 
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userType = 'P';
  final String gender;
  final double weight;
  final double height;
  final DateTime bday; 

  PatientModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.weight,
    required this.height,
    required this.bday,
  });


}