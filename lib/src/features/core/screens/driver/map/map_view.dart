// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapView extends StatefulWidget {
//   const MapView({Key? key}) : super(key: key);

//   @override
//   _MapViewState createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(5.9771265497759565, 10.182941414024645),
//     zoom: 14,
//   );

//   // adding multiple markers to the map
//   final List<Marker> myMarker = [];
//   final List<Marker> markerList = const [
//     Marker(
//       markerId: MarkerId('First'),
//       position: LatLng(5.9771265497759565, 10.182941414024645),
//       infoWindow: InfoWindow(title: 'My position'),
//     ),
//     Marker(
//       markerId: MarkerId('Second'),
//       position: LatLng(5.991481080388749, 10.18465802786213),
//       infoWindow: InfoWindow(title: 'Mile 4 Park'),
//     ),
//     Marker(
//       markerId: MarkerId('Second'),
//       position: LatLng(5.972743837017534, 10.175903297701446),
//       infoWindow: InfoWindow(title: 'Blue Pearl Hotel'),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     myMarker.addAll(markerList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: GoogleMap(
//           initialCameraPosition: _initialPosition,
//           mapType: MapType.normal,
//           markers: Set<Marker>.of(myMarker),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         )),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.location_searching),
//           onPressed: () async {
//             final GoogleMapController controller = await _controller.future;
//             controller.animateCamera(CameraUpdate.newCameraPosition(
//               const CameraPosition(
//                 target: LatLng(5.972743837017534, 10.175903297701446),
//                 zoom: 14,
//               ),
//             ));
//             setState(() {

//             });
//           },
//         ));
//   }
// }

import 'dart:async';

import 'package:chop_ya/src/common_widgets/assistants/assistant_methods.dart';
import 'package:chop_ya/src/common_widgets/infoHandler/app_info.dart';
import 'package:chop_ya/src/common_widgets/progress_dialog.dart';
import 'package:chop_ya/src/features/core/screens/driver/map/search_places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double searchLocationContainerHeight = 220;

  Position? driverCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;

  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoOrdinatesList = [];
  Set<Polyline> polyLineSet = {};

  // set markers
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateDriverPosition() async {
    // using await to get the current position
    // using location accuracy high to get the accurate / exact location using phone gps

    Position cDPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    driverCurrentPosition = cDPosition;

    // getting that current location on map we convert it to latlng
    LatLng latLngPosition = LatLng(
        driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);

    // moving the camera to the current location
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    // animating the camera to the current location
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // getting the address of the current location
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoordinates(
            driverCurrentPosition!, context);
    print("this is your address = " + humanReadableAddress);
  }

  @override
  void initState() {
    super.initState();
    // checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // google map view
          GoogleMap(
            // padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            polylines: polyLineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);

              // when ever the map is created we will assign our controller to newGoogleMapController
              newGoogleMapController = controller;

              // getting the bottom padding of the map
              // setState(() {
              //   bottomPaddingOfMap = 400;
              // });

              // calling the function to locate the driver position
              locateDriverPosition();
            },
          ),

          // ui for searching location
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 120),
              child: Container(
                height: searchLocationContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    children: [
                      // from
                      // curent location
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.add_location_alt_outlined,
                              color: Colors.black),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "From :",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                Provider.of<AppInfo>(context)
                                            .userPickUpLocation !=
                                        null
                                    // ? (Provider.of<AppInfo>(context).userPickUpLocation!.humanReadableAddress!).substring()
                                    ? Provider.of<AppInfo>(context)
                                        .userPickUpLocation!
                                        .humanReadableAddress!
                                    : "not getting location",
                                // Provider.of<AppInfo>(context).userPickUpLocation != null
                                //     ? Provider.of<AppInfo>(context).userPickUpLocation!.locationName!
                                //     : "not getting location",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Divider(height: 3, color: Colors.blueGrey.shade900),
                      const SizedBox(height: 16),
                      // to
                      // search / destination location
                      GestureDetector(
                        onTap: () async {
                          //  got to search places screen
                          var responseFromSearchScreen = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchPlacesScreen()));

                          if (responseFromSearchScreen == "obtainedDropoff") {
                            // draw routes - draw polyline

                            await drawPolyLineFromSourceToDestionation();
                          }
                        },
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Icon(Icons.add_location_alt_outlined,
                                color: Colors.black),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "To :",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  Provider.of<AppInfo>(context)
                                              .userDropOffLocation !=
                                          null
                                      ? Provider.of<AppInfo>(context)
                                          .userDropOffLocation!
                                          .locationName!
                                      : "Search destination location",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),
                      Divider(height: 3, color: Colors.blueGrey.shade900),
                      const SizedBox(height: 16),

                      // request for technician
                      ElevatedButton(
                          child: Text("Request for technician"),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> drawPolyLineFromSourceToDestionation() async {
    var sourcePosition =
        Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationPosition =
        Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    var sourceLatLng = LatLng(
        sourcePosition!.locationLatitude!, sourcePosition.locationLongitude!);
    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!,
        destinationPosition.locationLongitude!);

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(message: "Please wait..."),
    );
    var directionDetailsInfo =
        await AssistantMethods.obtainOriginToDestinationDirectionDetails(
            sourceLatLng, destinationLatLng);

    Navigator.pop(context);

    print("These are points =");
    print(directionDetailsInfo!.e_points);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResultList =
        pPoints.decodePolyline(directionDetailsInfo.e_points!);

    pLineCoOrdinatesList.clear();

    if (decodedPolylinePointsResultList.isNotEmpty) {
      decodedPolylinePointsResultList.forEach((PointLatLng pointLatLng) {
        pLineCoOrdinatesList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    // before drawing polyline we need to clear the polyline set

    polyLineSet.clear();

    // drawing polyline on the map
    // defining the polyline properties

    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId("PolylineID"),
        color: Colors.red,
        jointType: JointType.round,
        points: pLineCoOrdinatesList,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    // getting the bounds of the polyline
    LatLngBounds latLngBounds;
    if (sourceLatLng.latitude > destinationLatLng.latitude &&
        sourceLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destinationLatLng, northeast: sourceLatLng);
    } else if (sourceLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(sourceLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, sourceLatLng.longitude));
    } else if (sourceLatLng.latitude > destinationLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, sourceLatLng.longitude),
          northeast:
              LatLng(sourceLatLng.latitude, destinationLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: sourceLatLng, northeast: destinationLatLng);
    }

    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    // markers
    // source marker
    Marker sourceMarker = Marker(
      markerId: const MarkerId("sourceId"),
      position: sourceLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow:  InfoWindow(
        title: sourcePosition.locationName,
        snippet: "My Location",
      ),
    );

    // destination marker
    Marker destinationMarker = Marker(
      markerId: const MarkerId("destinationId"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow:  InfoWindow(
        title: destinationPosition.locationName,
        snippet: "My Location",
      ),
    );

    setState(() {
      markersSet.add(sourceMarker);
      markersSet.add(destinationMarker);
    });

    Circle sourceCircle = Circle(
      circleId: const CircleId("sourceId"),
      fillColor: Colors.green,
      center: sourceLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.greenAccent,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationId"),
      fillColor: Colors.orange,
      center: destinationLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.orangeAccent,
    );

    setState(() {
      circlesSet.add(sourceCircle);
      circlesSet.add(destinationCircle);
    });
  }
}
