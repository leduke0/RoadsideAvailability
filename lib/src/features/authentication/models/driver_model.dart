// creating our drivers model which is going to map the values of the drivers to the database

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

// the constructor if the model
  const UserModel({
    this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
  });

  // creating a map to map the values of the drivers to the database
 toJson() {
    return {
      'uid': uid,
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password': password,
    };
  }


  // Map user fetched from firestore to DriverModel
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      uid: document.id,
      fullName: data['FullName'],
      email: data['Email'],
      phoneNo: data['Phone'],
      password: data['Password'],
    );
  }
  }