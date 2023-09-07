import 'package:chop_ya/src/common_widgets/assistants/request_assistant.dart';
import 'package:chop_ya/src/common_widgets/infoHandler/app_info.dart';
import 'package:chop_ya/src/common_widgets/map_key.dart';
import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/features/core/models/direction_details_info.dart';
import 'package:chop_ya/src/features/core/models/directions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoordinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";

    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != "Error Occurred, Failed. No Response") {
      // get the address from the json data
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      // Directions
      Directions userAddress = Directions();
      userAddress.humanReadableAddress = humanReadableAddress;
      userAddress.locationLatitude = position.latitude;
      userAddress.locationLongitude = position.longitude;

      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userAddress);
    }
    return humanReadableAddress;
  }

  //  read current user info
  static void readCurrentUser() async {
    UserModel userModelCurrentInfo;
    String currentFirebaseUser = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("drivers")
        .doc(currentFirebaseUser);

    userRef.get().then((snapshot) {
      if (snapshot.exists) {
        userModelCurrentInfo = UserModel.fromSnapshot(
            snapshot.data() as DocumentSnapshot<Map<String, dynamic>>);
      }
    });
  }

  // draw route
  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(LatLng originPosition, LatLng destinationPosition) async {
    String urlOriginToDestionationDirectionDetails =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapkey";
  
    var responseDirectionApi = await RequestAssistant.receiveRequest(urlOriginToDestionationDirectionDetails);

    if(responseDirectionApi == "Error Occurred, Failed. No Response") {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points = responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text = responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value = responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text = responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value = responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];


    return directionDetailsInfo;

  
  }
}
