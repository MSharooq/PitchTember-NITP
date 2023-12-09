import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_a_million/Controller/AuthServices.dart';
import 'package:make_a_million/Helpers/custom_route_animation.dart';
import 'package:make_a_million/View/CompanyView/AddJobRole.dart';
import 'package:make_a_million/View/CompanyView/ListJobRoles.dart';
import 'package:provider/provider.dart';

import '../../Controller/AuthProvider.dart';
class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColorLight,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.white,
          elevation:2,
          //centerTitle: true,

          title:
              Text(
                  AuthServices.user?.name??"Make A Million",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width*.06)),


          actions:  [
            InkWell(
              onTap: (){
                print(AuthServices.isCandidate);
                Provider.of<AuthProvider>(context,listen: false).logout();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940'),
              ),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.push(context, SlidePageRoute(page: AddJobRole()));
          },
          child: Icon(Icons.add),
        ),
        body: const TabBarView(
          children: [
            ListJobRoles(type: 'Pending',),
            ListJobRoles(type: 'Completed',),

          ],
        )


      ),
    );
  }
}
