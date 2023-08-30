import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:chop_ya/src/repository/driver_repository/driver_repository.dart';
import 'package:chop_ya/src/repository/technician_repository/technician_repository.dart';
import 'package:get/get.dart';

class TechProfileController extends GetxController {
  static TechProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _techRepo = Get.put(TechnicianRepository());
  // Get Drivers Email and pass to the Driver Repository to get the Driver Details
  getTechnicianData(String technicianId) {
    // final email = _authRepo.firebaseUser.value?.email;
      return _techRepo.getTechnicianDetails(technicianId);
   
  }

  Future<List<TechModel>> getAllTechnician() async {
    return await _techRepo.allTechnician();
  }
}
