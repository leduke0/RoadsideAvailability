import 'package:chop_ya/src/features/core/models/request_service_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestRepository {
  Future<void> createRequest(Request request) async {
  await FirebaseFirestore.instance.collection('requests').add({
    'userID': request.userID,
    'requestTime': request.requestTime,
    'location': request.location,
    'status': request.status,
    // 'serviceProviderID': request.serviceProviderID,
    'serviceDetails': request.serviceDetails,
  });
}

  Future<void> updateRequest(Request request) async {
    await FirebaseFirestore.instance.collection('requests').doc(request.requestID).update({
      'userID': request.userID,
      'requestTime': request.requestTime,
      'location': request.location,
      'status': request.status,
      // 'serviceProviderID': request.serviceProviderID,
      'serviceDetails': request.serviceDetails,
    });
  }

  Future<void> deleteRequest(String requestID) async {
    await FirebaseFirestore.instance.collection('requests').doc(requestID).delete();
  }

  // Stream<List<Request>> requests() {
  //   return FirebaseFirestore.instance.collection('requests').snapshots().map((snapshot) => snapshot.docs.map((doc) => Request.fromFirestore(doc)).toList());
  // }

}