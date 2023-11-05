import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListJobRoles extends StatelessWidget {
  const ListJobRoles({super.key,required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (ctx, index) => ListTile(
          leading:  const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940'),
          ),
              title: Text("Team Manager",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16),),
              subtitle: Text("Job Role ${index + 1}"),
            ));
  }
}
