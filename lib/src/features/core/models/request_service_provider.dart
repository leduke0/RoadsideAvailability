import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requestID;
  String userID;
  DateTime requestTime;
  GeoPoint location;
  String status;
  String technicianId;
  String serviceDetails;

  Request({
    required this.requestID,
    required this.userID,
    required this.requestTime,
    required this.location,
    required this.status,
    required this.technicianId,
    required this.serviceDetails,
  });


  // convert request object to map
  

  // Create a factory constructor to convert Firestore data to a Request object
  // factory Request.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map;
  //   return Request(
  //     requestID: doc.id,
  //     userID: data['userID'] ?? '',
  //     requestTime: (data['requestTime'] as Timestamp).toDate(),
  //     location: data['location'],
  //     status: data['status'] ?? '',
  //     technicianId: data['serviceProviderID'] ?? '',
  //     serviceDetails: data['serviceDetails'] ?? '',
  //   );
  // }
}
