import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

              String driverUID = requestData['driverUID'];

            
              // Call the function to get the driver's name
              Future<String?> driverNameFuture = getDriverName(driverUID);

              // return a futurebuilder to get the driver's name
              return FutureBuilder<String?>(
                future: driverNameFuture,
                builder: (context, driverNameSnapshot) {
                  if (driverNameSnapshot.connectionState == ConnectionState.done) {
                    String? driverName = driverNameSnapshot.data;
                    return 
                    // ListTile(
                    //   title:  Text('Name: ${driverName ?? 'Unknown'}'),
                    //   subtitle: Text('Location: ${requestData['location']}'),
                    //   trailing: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Accept the request
                    //           acceptRequest(document.id);
                    //         },
                    //         child: Text('Accept'),
                    //       ),
                    //       SizedBox(width: 8),
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Deny the request
                    //           denyRequest(document.id);
                    //         },
                    //         child: Text('Deny'),
                    //       ),
                    //     ],
                    //   ),
                    // );
                    Row(
                      children: [
                         Icon(Icons.person, size: 25,),
                         Column(
                          children: [
                            Row(
                              children: [
                                Text("Name: ${driverName ?? 'Unknown'}"),
                                Text('Location: ${requestData['location']}'),
                                Spacer(),
                                // show the time the request was made in the format: HH:MM
                                Text(requestData['preferredTimm'].toString().substring(11, 16)),
                                
                              ],
                            ),
                            // display the service details
                            Text(requestData['serviceDetails']),
                            // display the accept and deny buttons
                            Row(
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
                          ],
                         ),
                      ],
                    );
                  } else if (driverNameSnapshot.hasError) {
                    return Text('Error: ${driverNameSnapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );


            

           


              // return ListTile(
              //   title: Text('Name: '),
              //   subtitle: Text('Location: ${requestData['location']}'),
              //   trailing: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           // Accept the request
              //           acceptRequest(document.id);
              //         },
              //         child: Text('Accept'),
              //       ),
              //       SizedBox(width: 8),
              //       ElevatedButton(
              //         onPressed: () {
              //           // Deny the request
              //           denyRequest(document.id);
              //         },
              //         child: Text('Deny'),
              //       ),
              //     ],
              //   ),
              // );
            }).toList(),
          );
        },
      ),
    );
  }

  void acceptRequest(String requestId) {
    // Implement logic to update the request status to "Accepted" in Firestore
    requestsCollection.doc(requestId).update({'status': 'Accepted'}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted successfully.')),
      );
    }).catchError((error) {
      print('Error accepting request: $error');
    });
  }

  void denyRequest(String requestId) {
    // Implement logic to update the request status to "Denied" in Firestore
    requestsCollection.doc(requestId).update({'status': 'Denied'}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request denied successfully.')),
      );
    }).catchError((error) {
      print('Error denying request: $error');
    });
  }

  Future<String?> getDriverName(String driverUID) async {
    try {
      final  driverSnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverUID)
          .get();
      final userData = UserModel.fromSnapshot(driverSnapshot);

      if (driverSnapshot.exists) {
        // Get the driver's name from the document data
        String driverName = userData.fullName;
        return driverName;
      } else {
        return null; // Driver not found
      }
    } catch (e) {
      print('Error getting driver name: $e');
      return null;
    }
  }
}
