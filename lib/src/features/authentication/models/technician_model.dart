import 'package:cloud_firestore/cloud_firestore.dart';

class TechModel {
  final String? uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String location;


// the constructor of the model
  const TechModel({
    this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.location,
  });


  // creating a map to map the values of the drivers to the database

  toJson() {
    return {
      'uid': uid,
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password': password,
      'Location': location,
    };
  }


   // Map user fetched from firestore to DriverModel
  factory TechModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TechModel(
      uid: document.id,
      fullName: data['FullName'],
      email: data['Email'],
      phoneNo: data['Phone'],
      password: data['Password'],
      location: data['Location'],
    );
  }
}