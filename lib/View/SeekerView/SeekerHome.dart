import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ListInterviews.dart';

class SeekerHome extends StatelessWidget {
  const SeekerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(

        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * .15),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).primaryColorLight,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Theme.of(context).primaryColorLight,
            elevation:2,
            toolbarHeight: size.height * .15,
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Hello,',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width*.045)),
                TextSpan(
                    text: '\nNeethika Sumesh',
                    style: GoogleFonts.poppins(
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width*.05)),
              ]),
            ),
            actions: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D'),
              ),
              SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
             indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    "Pending",
                    style: GoogleFonts.poppins(

                        fontWeight: FontWeight.w600,
                        fontSize: size.width * .04),
                  ),
                ),
                Tab(
                  child: Text(
                    "Completed",
                    style: GoogleFonts.poppins(

                        fontWeight: FontWeight.w600,
                        fontSize: size.width * .04),
                  ),
                ),

            ],),
          ),
        ),
        body: const TabBarView(
           children: [
             ListInterviews(type:"Pending"),
             ListInterviews(type: "Completed")

           ],

         ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
