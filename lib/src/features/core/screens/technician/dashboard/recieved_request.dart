import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TechnicianDashboard extends StatefulWidget {
  @override
  _TechnicianDashboardState createState() => _TechnicianDashboardState();
}

class _TechnicianDashboardState extends State<TechnicianDashboard> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technician Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: requestsCollection
            .where('technicianUID', isEqualTo: currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No requests available for this technician.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> requestData =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Request ID: ${requestData['requestID']}'),
                subtitle: Text('Location: ${requestData['location']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Accept the request
                        acceptRequest(document.id);
                      },
                      child: Text('Accept'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Deny the request
                        denyRequest(document.id);
                      },
                      child: Text('Deny'),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void acceptRequest(String requestId) {
    // Implement logic to update the request status to "Accepted" in Firestore
    requestsCollection
        .doc(requestId)
        .update({'status': 'Accepted'})
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted successfully.')),
      );
    }).catchError((error) {
      print('Error accepting request: $error');
    });
  }

  void denyRequest(String requestId) {
    // Implement logic to update the request status to "Denied" in Firestore
    requestsCollection
        .doc(requestId)
        .update({'status': 'Denied'})
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request denied successfully.')),
      );
    }).catchError((error) {
      print('Error denying request: $error');
    });
  }
}
