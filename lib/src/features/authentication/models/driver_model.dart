// creating our drivers model which is going to map the values of the drivers to the database

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

// creating our drivers model which is going to map the values of the drivers to the database

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
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    // final userCredentials =  FirebaseAuth.instance.currentUser;

    final data = document.data()!;
    return UserModel(
      // assign the id
      uid: document.id,
      fullName: data['FullName'],
      email: data['Email'],
      phoneNo: data['Phone'],
      password: data['Password'],
    );
  }
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  // create a copywith method to copy the values of the drivers to the database
  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNo,
    String? password,
  }) {
    return UserModel(
      // if the uid is not null then replace the uid with the current uid
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, email: $email, phoneNo: $phoneNo, password: $password)';
  }
}
