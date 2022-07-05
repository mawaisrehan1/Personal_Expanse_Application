import 'package:personal_expanse_app/screens/my_home_screen.dart';



class Routes{
  static String myHomeScreen = "/myHomeScreen";
  // static String loginScreen = "/loginScreen";
  // static String weatherScreen = "/weatherScreen";
  // static String tasbeehScreen = "/tasbeehScreen";

  static getRoutes(){
    return {
      myHomeScreen:(context) =>  const MyHomeScreen(),
    };
  }
}