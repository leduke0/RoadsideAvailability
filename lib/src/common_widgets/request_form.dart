import 'package:chop_ya/src/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RequestForm extends StatefulWidget {
  final String technicianUID;

  // get current users uid
  // final String uid = FirebaseAuth.instance.currentUser.uid;


  RequestForm(this.technicianUID);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serviceDetailsController = TextEditingController();
  DateTime? preferredTime;
  final TextEditingController carModelController = TextEditingController();

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                const Text(
                  'Request Service',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter your location',
                  ),
                ),
               
                const SizedBox(height: 16),
                TextField(
                  controller: carModelController,
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
                    hintText: 'Enter your car model',
                  ),
                ),
                TextField(
                  controller: serviceDetailsController,
                  decoration: const InputDecoration(
                    labelText: 'Service Details',
                    hintText: 'Describe your service request',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
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
                
                const SizedBox(height: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onSurface: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                
                      String location = locationController.text;
                      String serviceDetails = serviceDetailsController.text;
                      String carModel = carModelController.text;
                            
                      sendRequestToTechnician(
                        widget.technicianUID,
                        location,
                        serviceDetails,
                        preferredTime,
                        carModel,
                      );
                            
                      locationController.clear();
                      serviceDetailsController.clear();
                      preferredTime = null;
                      carModelController.clear();
                            
                      Navigator.pop(context);
                    },
                    child: const Text('Submit Request'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendRequestToTechnician(
    String technicianUID,
    String location,
    String serviceDetails,
    DateTime? preferredTime,
    String carModel,
  ) {
    // Implement your logic to send the request to Firestore or your backend
    // Here, you can use Firestore to store the request with the technician's UID
    // and other details, including preferredTime.
    // Example Firestore code:
    FirebaseFirestore.instance.collection('requests').add({
      'technicianUID': technicianUID,
      'location': location,
      'serviceDetails': serviceDetails,
      'preferredTime': preferredTime,
      'carModel': carModel,
      'status': 'Pending',
      // Add more fields as needed
    });
  }
}
