import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PendingInterview extends StatelessWidget {
  const PendingInterview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Pending Interview",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: size.width * .05),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: size.width * .1,
              backgroundImage: NetworkImage(
                  "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940"),
            ),
            Text(
              "Product Manager",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: size.width * .05),
            ),
            Text(
              "Netflix",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: size.width * .04),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Text(
              "Job Description",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: size.width * .04),
            ),
            Text("Hey kid how are you hope you are fine",style: GoogleFonts.poppins(),),
            SizedBox(
              height: size.height * .05,
            ),
            Text(
              "Schedule",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: size.width * .04),

            ),
            Text('On Nov 10th from 10:00am to 11:00am 2023'),
            SizedBox(
              height: size.height * .03,
            ),
            ElevatedButton(onPressed: (){}, child: Text("Join Event",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: size.width * .04),
            ),style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: size.width*.15,vertical: size.height*.015),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),),

          ],
        ),
      ),
    );
  }
}
