import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_a_million/Controller/AuthProvider.dart';
import 'package:make_a_million/View/CompanyView/CompanyHome.dart';
import 'package:make_a_million/View/LandingPage.dart';
import 'package:make_a_million/View/LoginPage.dart';
import 'package:provider/provider.dart';

import 'Controller/AuthServices.dart';
import 'View/CandidateView/SeekerHome.dart';

void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      builder: (context, child) {
        return MakeAMillion();}
        )
      );
  }

class MakeAMillion extends StatefulWidget {
  const MakeAMillion({super.key});

  @override
  State<MakeAMillion> createState() => _MakeAMillionState();
}

class _MakeAMillionState extends State<MakeAMillion> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context, listen: false).checkAuthState();
    AuthServices.setIsCandidate();
    super.initState();
  }

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
          primaryColorLight: const Color(0xffF1F4FF),

        ),


        debugShowCheckedModeBanner: false,
        title: 'Make A Million',
        home: Consumer(
          builder: (context, AuthProvider auth, child) {

            if (auth.isAuthenticated == false){
              return  const LandingPage();
            } else if (AuthServices.isCandidate) {
              return const SeekerHome();
            }
            else{
              return const CompanyHome();
            }
          },
        ));
  }
}
