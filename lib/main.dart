import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_a_million/View/LandingPage.dart';
import 'package:make_a_million/View/SeekerView/SeekerHome.dart';

void main() {
  runApp(const MakeAMillion());
}

class MakeAMillion extends StatelessWidget {
  const MakeAMillion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(

            systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
              // Status bar color
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),

            primaryColor: const Color(0xff1F41BB),
            primaryColorLight:  const Color(0xffF1F4FF),

        ),



        debugShowCheckedModeBanner: false,
        title: 'Make A Million',
        home:SeekerHome());
  }
}
