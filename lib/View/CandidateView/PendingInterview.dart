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
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        elevation: 0,

        backgroundColor: Colors.transparent,
        title: Text("Pending Interview",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: size.width*.05
        ),),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            CircleAvatar(
              radius: size.width*.1,
              backgroundImage: NetworkImage("https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940"),
            )

          ],
        ),
      ),
    );
  }
}
