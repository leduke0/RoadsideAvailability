import 'package:chop_ya/src/common_widgets/progress_dialog.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestForm extends StatefulWidget {
  // final String technicianId;
  // get the technician id from the previous screen
  final String technicianId;

  // final String driverId;

  // // get current users uid
  final String driverId = FirebaseAuth.instance.currentUser!.uid;

  RequestForm(this.technicianId);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serviceDetailsController =
      TextEditingController();
  DateTime? preferredTime;
  final TextEditingController carModelController = TextEditingController();
  bool requestSent = false; //track if the reuest has been sent

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != preferredTime) {
      setState(() {
        preferredTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;
    if (picked != null) {
      final DateTime currentTime = DateTime.now();
      final DateTime pickedTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        preferredTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    locationController.dispose();
    serviceDetailsController.dispose();
    carModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request Form'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(tDefaultSize),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Request Service',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      hintText: 'Enter your location',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: carModelController,
                    decoration: const InputDecoration(
                      labelText: 'Car Model',
                      hintText: 'Enter your car model',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your car model';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: serviceDetailsController,
                    decoration: const InputDecoration(
                      labelText: 'Service Details',
                      hintText: 'Describe your service request',
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please describe your service details';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          // validate if preferredTime is null

                          preferredTime == null
                              ? 'Preferred Time'
                              : 'Preferred Time: ${DateFormat('yyyy-MM-dd HH:mm').format(preferredTime!)}',
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () => _selectDate(context),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.teal,
                          onSurface: Colors.teal,
                        ),
                        child: const Text('Select Date'),
                      ),
                      const SizedBox(width: 8),
                      // ElevatedButton(
                      //   onPressed: () => _selectTime(context),
                      //   child: const Text('Select Time'),
                      // ),
                      OutlinedButton(
                        onPressed: () => _selectTime(context),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.teal,
                          onSurface: Colors.teal,
                        ),
                        child: const Text('Select Time'),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      // minimumSize: const Size(200, 50),
                    ),
                    onPressed: () async {
                      //  String driverId = FirebaseAuth.instance.currentUser!.uid;
                      // get the current logged in user id from firestore

                      if (_formKey.currentState!.validate()) {
                        String location = locationController.text;
                        String serviceDetails = serviceDetailsController.text;
                        String carModel = carModelController.text;

                        await sendRequestToTechnician(
                          // document id of the request
                          widget.driverId,
                          widget.technicianId,
                          location,
                          serviceDetails,
                          preferredTime,
                          carModel,
                        );

                        locationController.clear();
                        serviceDetailsController.clear();
                        preferredTime = null;
                        carModelController.clear();

                        // Set requestSent to true when the request is sent
                        setState(() {
                          requestSent = true;
                        });

                        // Show the success dialog
                        _showSuccessDialog();

                        
                      }
                      // write statement to display success message if request is sent successfully
                      // else display error message
                    },
                    child: const Text('Submit Request'),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
       
      ),
    );
  }

   sendRequestToTechnician(
    // String requestID,
    String driverId,
    String technicianId,
    String location,
    String serviceDetails,
    DateTime? preferredTime,
    String carModel,
  ) async {
    //  final User user = _firebaseAuth.currentUser!;

    // Implement your logic to send the request to Firestore or your backend
    // Here, you can use Firestore to store the request with the technician's UID
    // and other details, including preferredTime.
    // Example Firestore code:
    final requestDocument =
        await FirebaseFirestore.instance.collection('requests').add({
      // add document id of the request
      'driverUID': driverId,
      'technicianUID': technicianId,
      'location': location,
      'serviceDetails': serviceDetails,
      'preferredTime': preferredTime,
      'carModel': carModel,
      'status': 'Pending',
      // Add more fields as needed
    });

    // get the generated document id
    final requestId = requestDocument.id;

    // add the request id to the document
    await requestDocument.update({
      'requestID': requestId,
    });
  }

   void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Request Sent Successfully',textAlign: TextAlign.center, style:  TextStyle(color: Colors.green),),
          content:  const Text('Your request has been sent successfully.', textAlign: TextAlign.center, style:  TextStyle(color: Colors.green),),
          // add an icon to the dialog
          icon: const Icon(Icons.check_circle, color: Colors.green),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Reset requestSent and dismiss the dialog
                setState(() {
                  requestSent = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
