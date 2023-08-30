import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:chop_ya/src/repository/driver_repository/driver_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(DriverRepository());
  // Get Drivers Email and pass to the Driver Repository to get the Driver Details
  getDriverData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getDriverDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllDriver() async {
    return await _userRepo.allDriver();
  }

  getTechnicianData() {}
}
