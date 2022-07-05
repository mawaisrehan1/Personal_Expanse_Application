import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:personal_expanse_app/routes/routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
           // home: MyHomePage(),
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            routes: Routes.getRoutes(),
            initialRoute: Routes.myHomeScreen,
          );
        }
    );
  }
}

// 5 k 7 video sy start...
