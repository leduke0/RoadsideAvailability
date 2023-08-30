import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/signup/controllers/techProfile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:get/get.dart';

class TechnicianDetailsScreen extends StatelessWidget {
  const TechnicianDetailsScreen({Key? key, required this.technicianId}) : super(key: key);
  final String technicianId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TechProfileController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Technician Details'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getTechnicianData(technicianId),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final TechModel userData = snapshot.data as TechModel;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      const Center(
                        child: SizedBox(
                          // height: 50,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 238, 66, 54),
                            child: Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: SizedBox(
                          height: 30,
                          child: Text(
                            userData.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        child: FlutterRating(
                          rating: 3.5,
                          size: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.email,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.phone,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.green,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                            title: Text(
                          userData.location,
                          style: const TextStyle(fontSize: 16),
                        )),
                      ),
                      const SizedBox(
                        height: 70,
                        child: ListTile(
                            title: Text(
                          'Service per hour: 2000frs',
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                        child: ListTile(
                          title: Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                              'Hello! As a roadside vehicle mechanic, your services are essential for drivers '),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
