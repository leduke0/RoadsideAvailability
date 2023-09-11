import 'package:chop_ya/src/common_widgets/form/search_bar.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/signup/controllers/techProfile_controller.dart';
import 'package:chop_ya/src/features/core/screens/driver/dashboard/techniciansDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:get/get.dart';

class TechnicianScreen extends StatefulWidget {
  const TechnicianScreen({Key? key}) : super(key: key);

  @override
  State<TechnicianScreen> createState() => _TechnicianScreenState();
}

class _TechnicianScreenState extends State<TechnicianScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TechProfileController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text('Technicians'),
          centerTitle: true,
        ),
        body: ListView(children: [
          const SizedBox(
            height: 20,
          ),
          const SearchBar(),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(tDefaultSize * 0.5),
            child: Column(
              children: [
                FutureBuilder(
                  future: controller.getAllTechnician(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        // TechModel techData = snapshot.data as TechModel;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (c, index) {
                            print(snapshot.data![index].uid);
                            return ListView(
                              shrinkWrap: true,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => TechnicianDetailsScreen(
                                          technicianId: snapshot
                                              .data![index].uid
                                              .toString(),
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF36454f),
                                        ),
                                        child: const Center(
                                            child:
                                                // Text("JS", style: TextTheme.headline6?.apply(color: Colors.white),
                                                // )
                                                Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.white,
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name : ${snapshot.data![index].fullName}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Location: ${snapshot.data![index].location}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  "Rating: ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Center(
                                                  child: FlutterRating(
                                                    rating: 3.5,
                                                    size: 20,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 0,
                                              indent: 20,
                                              endIndent: 20,
                                            )
                                            // const Center(
                                            //   child: FlutterRating(
                                            //     rating: 3.5,
                                            //     size: 20,
                                            //     color: Colors.amber,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // const Divider(
                                //   thickness: 0,
                                //   indent: 20,
                                //   endIndent: 20,
                                // )
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // return SizedBox(
  //             height: 100,
  //             child: ListView(
  //               shrinkWrap: true,
  //               children: [
  //                   SizedBox(
  //                     width: 260,
  //                     height: 50,
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           width: 100,
  //                           height: 90,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: const Color(0xFF36454f),
  //                           ),
  //                           child: const Center(
  //                               child:
  //                                   // Text("JS", style: TextTheme.headline6?.apply(color: Colors.white),
  //                                   // )
  //                                   Icon(
  //                             Icons.person,
  //                             size: 50,
  //                             color: Colors.white,
  //                           )),
  //                         ),
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //                         Flexible(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children:  [
  //                                Text(
  //                                 data['FullName'],
  //                                 style: const TextStyle(
  //                                   fontSize: 20,
  //                                 ),
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                                const SizedBox(
  //                                 height: 4,
  //                               ),
  //                                Text(
  //                                 "Location: ${data['Location']}",
  //                                 style: const TextStyle(
  //                                   fontSize: 20,

  //                                 ),
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                               const Center(
  //                                 child: FlutterRating(
  //                                   rating: 3.5,
  //                                   size: 20,
  //                                   color: Colors.amber,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 const SizedBox(
  //                   width: 50,
  //                 ),
  //               ],
  //             ),
  //           );
}
