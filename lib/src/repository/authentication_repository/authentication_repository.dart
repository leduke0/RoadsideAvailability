import 'package:chop_ya/src/common_widgets/form/techNavbar.dart';
import 'package:chop_ya/src/common_widgets/navigationBar.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_passsword_otp/otp_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/login/login_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/welcomeScreen/welcome_screen.dart';
// import 'package:chop_ya/src/features/core/screens/driver/dashboard/dashboard.dart';
import 'package:chop_ya/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // firebase class firstly firebase authentication secondly firebase authenticated users already exist or not
  // Variables
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  // contains all the information about the user / logout / login / create account
  late final Rx<User?> firebaseUser;
  // final _user = Rx<User>( FirebaseAuth.instance.currentUser!);
  var verificationId = ''.obs;
  // late Stream<User?> _authStateChanges;
  
  // obs observable

  // when a user is loggedin or loggedout we redirect to the home page or particular page
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
  }

  // redeirect to the home page or particular page
  // _setInitialScreen(User? user)  {

  //   if (user == null) {
  //     Get.offAll(() => const WelcomeScreen());
  //   } else if (user.emailVerified && user.uid  _db.collection('drivers').doc(user.uid)) {
  //     Get.to(() =>  TechNavBar());
  //   } else {
  //     Get.to(() =>  NavBar());
  //   } 

  //   // if (user != null && user.emailVerified && user.uid == _db.collection('drivers').doc(user.uid)) {
  //   //   Get.to(() =>  NavBar());
  //   // } else if (user != null && user.emailVerified && user.uid == _db.collection('technicians').doc(user.uid)) {
  //   //   Get.to(() =>  TechNavBar());
  //   // } else {
  //   //   Get.offAll(() => const WelcomeScreen());
  //   // }
   
  //   // if (user == null) {
  //   //   Get.offAll(() => const WelcomeScreen());
  //   // } else {
  //   //   Get.to(() => NavBar());
  //   // }


  //   // check if current user is a driver or technician and redirect to the particular page
  //   // if (FirebaseAuth.instance.currentUser == _db.collection('drivers') ) {
  //   //   Get.to(() => NavBar());
  //   // } else {
  //   //   Get.to(() => TechNavBar());
  //   // }
    

  // }


  // Future<void> phoneAuthentication(String phoneNo) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     verificationCompleted: (credential) async {
  //       await _auth.signInWithCredential(credential);
  //     },
  //     codeSent: (verificationId, resendToken) {
  //       this.verificationId.value = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {
  //       this.verificationId.value = verificationId;
  //     },
  //     verificationFailed: (e) {
  //       if (e.code == 'invalid-phone-number') {
  //         Get.snackbar('Error', 'The provided phone number is not valid.');
  //       } else {
  //         Get.snackbar('Error', 'Something went wrong. Try again.');
  //       }
  //     },
  //   );
  // }

   Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again.');
        }
      },
    );
  }

  // this will be called when users enter the otp and click on verify button
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    // if credentials.user is not null then return true else return false means if user is logged in then return true else return false
    return credentials.user != null ? true : false;
  }

  // create account


  // create account
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
       await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      

      


      // after creating the user, create a new document for the user in the users collection
      // await _db.collection('drivers').doc(_auth.currentUser!.uid).set({
      //   'email': email,
      //   'password': password,

        
      // });
      
      firebaseUser.value != null
          ? Get.to(() => const OTPScreen())
          : Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  // login
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  // logout
  Future<void> logout() async => await _auth.signOut();
}
