import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class JobDetails extends StatelessWidget {
  const JobDetails({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Role Details", ),backgroundColor: Colors.white,foregroundColor: Colors.black,),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940'),
          ),
          Text(data['role'],style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
          SizedBox(height: size.height*.03,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width*.1),
            child: Text(data['description'],style: GoogleFonts.poppins(fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: size.height*.03,),
          Text("Applicants",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
          Expanded(
            child: ListView.builder(
              itemCount: data['applicants'].length,
                itemBuilder: (ctx,index){

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                title: Text(data['applicants'][index]['email'],style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w400),),
              );
            }),
          )

        ],
      ),
    );
  }
}
