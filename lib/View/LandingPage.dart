import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_a_million/Helpers/custom_route_animation.dart';
import 'package:make_a_million/View/LoginPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle( //<-- SEE HERE
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Image.asset(
              'assets/images/img.png',
              width: size.width * .8,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .1),
              child: Text(
                'Elevating talent, \nSimplifying hiring',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: size.width * .065,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * .025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .1),
              child: Text(
                'We help you find the best talent for your company',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: size.width * .04,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: size.height * .06,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                child: Text(
                  'Who are You?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: size.width * .05,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,SlidePageRoute(page: const LoginPage( role: 'Company',)));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * .1,
                          vertical: size.height * .015),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))
                  ),
                  child:  Text("Company",
                      style: GoogleFonts.poppins(
                          fontSize: size.width * .04,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,SlidePageRoute(page: const LoginPage( role: 'Candidate',)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .1,
                            vertical: size.height * .015),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))
                    ),
                    child: Text("Candidate",
                        style: GoogleFonts.poppins(
                            fontSize: size.width * .04,
                            color: Colors.black,
                            fontWeight: FontWeight.w600))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
