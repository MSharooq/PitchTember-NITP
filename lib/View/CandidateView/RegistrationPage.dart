import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:make_a_million/Controller/AuthServices.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

import '../../Helpers/custom_route_animation.dart';
import '../CompanyView/CompanyHome.dart';
import 'SeekerHome.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key, required this.email, required this.password});

  final String type = AuthServices.isCandidate ? "Candidate" : "Company";
  final String email;
  final String password;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool isLoading = false;
  PlatformFile? image;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  ImageProvider get imageProvider {
    if (image == null) {
      return const NetworkImage(
          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D");
    } else {
      return FileImage(File(image!.path!));
    }
  }

  String text = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQuery.height * .025,
              ),
              SizedBox(
                height: mediaQuery.height * .25,
                width: mediaQuery.width * .7,
                child: Image.asset(
                  "assets/images/profile.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: mediaQuery.height * .05,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mediaQuery.width * .02,
                    right: mediaQuery.width * .45),
                child: Text("Almost there.!",
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: mediaQuery.width * .06)),
              ),
              Text(
                "Let's add a few details about you to get started.!",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
              Center(
                child: CircleAvatar(
                    radius: mediaQuery.width * .1,
                    backgroundImage: imageProvider),
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      final result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                          withData: true);
                      image = result?.files.first;
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "Add Photo",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: mediaQuery.width * .04,
                        color: Theme.of(context).primaryColor),
                  )),
              SizedBox(
                height: mediaQuery.height * .01,
              ),
              Form(
                  key: _key,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * .05),
                    height: mediaQuery.height * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              fillColor: Theme.of(context).primaryColorLight,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        widget.type == "Candidate"
                            ? ElevatedButton.icon(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.any);
                                  PlatformFile file = result!.files.first;
                                  text =
                                      await ReadPdfText.getPDFtext(file.path!);
                                  print(text);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mediaQuery.width * .2,
                                      vertical: mediaQuery.height * .02),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                icon: Icon(
                                  Ionicons.document_text_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                label: Text(
                                  "Upload CV",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: mediaQuery.width * .04),
                                ))
                            : TextFormField(
                                style: GoogleFonts.nunitoSans(),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    prefixIcon: Icon(
                                      Ionicons.home_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    hintText: "Address",
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38),
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                        ElevatedButton(
                            onPressed: () async {
                              bool isValid = _key.currentState!.validate();
                              if (isValid) {
                                bool isSuccess = await AuthServices.register(
                                    widget.email,
                                    widget.password,
                                    _nameController.text,
                                    text,
                                    context);
                                if (isSuccess) {
                                  Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          page: widget.type == "Candidate"
                                              ? SeekerHome()
                                              : CompanyHome()));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.width * .2,
                                  vertical: mediaQuery.height * .02),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Create Account",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: mediaQuery.width * .04),
                                  ))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
