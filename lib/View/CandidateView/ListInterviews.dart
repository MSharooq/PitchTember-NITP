import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_a_million/Helpers/custom_route_animation.dart';

import 'PendingInterview.dart';

class ListInterviews extends StatelessWidget {
  const ListInterviews({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context, SlidePageRoute(page: const PendingInterview()));
            },
            leading: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D'),
            ),
            title: Text("Interview ${index + 1}",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * .04)),
            subtitle: Text("Interview ${index + 1}",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * .035)),
            trailing: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02, vertical: size.width * .01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: type == 'Pending' ? Colors.red : Colors.green,
              ),
              child: Text(
                type,
                style: GoogleFonts.poppins(
                    color: type == "Pending" ? Colors.black : Colors.white,
                    fontSize: size.width * .03,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
        });
  }
}
