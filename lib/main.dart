import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/splash_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel/view/Home_Screen.dart';
import 'package:travel/view/Main_Screen.dart';
import 'package:travel/view/Visit_Screen.dart';

//import 'package:travel/view/map_Screen.dart';
const kDefaultColor = Colors.deepPurple;
void main() {
  runApp(const MyApp());
}

// void main() {
//   runApp(
//     MaterialApp(
//       home: SplashView(
//         backgroundColor: Colors.cyan,
//         loadingIndicator: RefreshProgressIndicator(),
//         logo: FlutterLogo(),
//         done: Done(MainScreen()),
//       ),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Tour Guide',
      debugShowCheckedModeBanner: false,
      home: SplashView(
        backgroundColor: Colors.white,
        //loadingIndicator: RefreshProgressIndicator(),
        logo: SizedBox(
          height: 790,
          child: Image(image:AssetImage('assets/images/travelby.png') ,
                 ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'from',
              style: TextStyle(
                  //fontFamily: 'YatraOne',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'WwYyyQ',
              style: TextStyle(
                  //fontFamily: 'YatraOne',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        done: Done(
            HomeScreen(),
            animationDuration: Duration(seconds: 2),
            curve: Curves.easeOutExpo,
        ),
      )

    );
  }
}
