import 'dart:convert';
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:excel/excel.dart';
import 'package:make_a_million/Controller/JobServices.dart';

class AddJobRole extends StatelessWidget {
  AddJobRole({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> applicants = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          child: Column(children: [
            SizedBox(
              height: size.height * .05,
            ),
            Image.asset("assets/images/add_job.png"),
            Text(
              "Add a New Job Opening",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  fontSize: size.width*.055),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return "Invalid name";
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Icon(
                          Ionicons.person_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Name",
                        hintStyle: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, color: Colors.black38),
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      return null;
                    },
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 30),
                        prefixIcon: Icon(
                          Ionicons.document_text_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Job Description",
                        hintStyle: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, color: Colors.black38),
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.any
                        );
                        PlatformFile file = result!.files.first;
                         applicants = await extractEmailsFromExcel(file.path!,0);
                        print(applicants);


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                        Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .08,
                            vertical: size.height * .015),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(
                        Ionicons.document_text_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Upload List",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * .04),
                      )),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool isSuccess = await JobServices.addJobRole(_nameController.text, _descriptionController.text, applicants);
                        if(isSuccess){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Job Created Successfully"),backgroundColor: Colors.green,));
                          Navigator.pop(context);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .2,
                            vertical: size.height * .02),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child:Text(
                        "Create Job",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * .04),
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
  Future<List<String>> extractEmailsFromExcel(String filePath, int emailColumnIndex) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<String> emails = [];

    // Assuming that you have a single sheet
    var sheet = excel.tables.keys.first;
    var rows = excel.tables[sheet]!.rows;

    for (int rowIndex = 1; rowIndex < rows.length; rowIndex++) {
      var cellValue = rows[rowIndex][emailColumnIndex]?.value; // Use the correct email column index
      print(cellValue);
      if (cellValue != null) {

        String potentialEmail = cellValue.toString();
        // Simple validation to check if the string looks like an email
       emails.add(potentialEmail);
      }
    }

    return emails;
  }
}
