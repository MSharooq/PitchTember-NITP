import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_a_million/Controller/JobServices.dart';
import 'package:make_a_million/Helpers/custom_route_animation.dart';
import 'package:make_a_million/View/CompanyView/JobDetails.dart';

class ListJobRoles extends StatelessWidget {
  const ListJobRoles({super.key,required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: JobServices.getCompanyJobs(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(
            child: Text("No Jobs Found",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16),),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => ListTile(
              onTap: (){

                Navigator.push(context, SlidePageRoute(page: JobDetails(data: snapshot.data![index],)));
              },
              leading:  const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940'),
              ),
                  title: Text(snapshot.data![index]['role'],style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),),
                  subtitle: SizedBox(
                    height: size.height*.025,
                      child: Text(snapshot.data![index]['description'],overflow:TextOverflow.ellipsis ,)),
                ));
      }
    );
  }
}
