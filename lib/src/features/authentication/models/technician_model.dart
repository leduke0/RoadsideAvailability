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
  factory TechModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
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

  // create a copywith method to copy the values of the drivers to the database
  TechModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNo,
    String? password,
    String? location,
  }) {
    return TechModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      password: password ?? this.password,
      location: location ?? this.location,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, email: $email, phoneNo: $phoneNo, password: $password, location: $location)';
  }
}
