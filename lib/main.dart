import 'package:chop_ya/firebase_options.dart';
import 'package:chop_ya/src/features/authentication/screens/login/login_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:chop_ya/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 700),
        home: const Scaffold(
            body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        )));
  }
}

// class AppHome extends StatelessWidget {
//   const AppHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('App Home'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add_shopping_cart),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children: [
//             Text('Hello World',
//                 style: Theme.of(context).textTheme.headline2),
//             const Text('sub Hello World'),
//             const Text('sub Hello World'),
//             ElevatedButton(
//                 onPressed: () {}, child: const Text('Elevated Button')),
//             OutlinedButton(
//                 onPressed: () {}, child: const Text('Outlined Button')),
//             const Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Image(image: AssetImage('assets/images/rapair.jpg'))),
//           ],
//         ),
//       ),
//     );
//   }
// }
