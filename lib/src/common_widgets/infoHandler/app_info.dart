import 'package:chop_ya/src/features/core/models/directions.dart';
import 'package:flutter/material.dart';

class AppInfo extends ChangeNotifier {

  Directions? userPickUpLocation, userDropOffLocation;

  void updatePickUpLocationAddress(Directions userAddress) {
    userPickUpLocation = userAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress) {
    userDropOffLocation= dropOffAddress;
    notifyListeners();
  }

}