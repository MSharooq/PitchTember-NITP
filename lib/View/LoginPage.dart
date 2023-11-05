import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:make_a_million/Controller/AuthServices.dart';
import 'package:make_a_million/Model/Candidate.dart';
import 'package:make_a_million/View/CandidateView/SeekerHome.dart';
import 'package:make_a_million/View/CompanyView/CompanyHome.dart';
import 'package:make_a_million/View/SignUpPage.dart';

import '../Controller/AuthValidator.dart';
import '../Helpers/custom_route_animation.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  final String role = AuthServices.isCandidate? "Candidate" : "Company";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              spacer(.125),
              Center(
                child: SizedBox(
                  height: mediaQuery.height * .3,
                  width: mediaQuery.width * .7,
                  child: Image.asset(
                    "assets/images/login.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              spacer(.05),
              Text(
                "Welcome Back.!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: mediaQuery.width * .06),
              ),
              Text(
                "Login to your account and get started.",
                style: GoogleFonts.poppins(
                    color: Theme.of(context).primaryColor,
                    fontSize: mediaQuery.width * .04),
              ),
              spacer(.03),
              Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * .05),
                    height: mediaQuery.height * .32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            return AuthValidators.emailValidator(value!);
                          },
                          style: GoogleFonts.poppins(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Ionicons.mail_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Email",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38),
                              fillColor: Theme.of(context).primaryColorLight,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return AuthValidators.passwordValidator(value!);
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              prefixIcon: Icon(
                                Ionicons.lock_closed_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Password",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38),
                              fillColor: Theme.of(context).primaryColorLight,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: mediaQuery.width * .5),
                          child: Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                            style: GoogleFonts.nunitoSans(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                           bool isSuccess =   await AuthServices.login(_emailController.text, _passwordController.text, context);
                           print(isSuccess);
                              isLoading = false;
                           if(isSuccess){
                             if(AuthServices.isCandidate){
                                Navigator.push(context,SlidePageRoute(page: const SeekerHome()));

                             }
                             else{
                               Navigator.push(context, SlidePageRoute(page: CompanyHome()));
                             }
                           }
                           else{
                             setState(() {

                             });
                           }

                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: mediaQuery.width * .15,
                                        vertical: mediaQuery.height * .015)),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: mediaQuery.width * .04),
                                  )),
                      ],
                    ),
                  )),
              SizedBox(
                height: mediaQuery.height * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlidePageRoute(page: const SignUpPage()),
                          );
                        },
                        child: Text(
                          "Sign-Up",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget spacer(double height) => SizedBox(
        height: MediaQuery.of(context).size.height * height,
      );

  void showMessage(String message, Color color) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
      ));
}
