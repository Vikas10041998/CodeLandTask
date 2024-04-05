import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'GColor.dart';
import 'main.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var width;
  var height;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late String _username = "vikas@gmail.com";
  late String _password = "12345678";
  signInWithEmailAndPassword()async {
    try{
      setState(() {
        _isLoading = true;
      });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _username, password: _password);
      setState(() {
        _isLoading = false ;
      });
    }on FirebaseAuthException catch (e){
      setState(() {
        _isLoading = false;
      });
      if(e.code == 'user-not-found'){
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No User found for this credentials", style: TextStyle(color: Colors.black),))
        );
      }else if(e.code == 'wrong-password'){
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wrong password provided for this user", style: TextStyle(color: Colors.black),))
        );
      }
    }
  }



  // Future<void> signInWithEmailAndPassword(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(
  //         email: emailcontroller.text,
  //         password: passwordcontroller.text,
  //       );
  //
  //       // If login is successful, navigate to the next screen
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadScreen(),));
  //     } on FirebaseAuthException catch (e) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       if (e.code == 'user-not-found') {
  //         Fluttertoast.showToast(msg: 'No user found with this email');
  //       } else if (e.code == 'wrong-password') {
  //         Fluttertoast.showToast(msg: 'Wrong password');
  //       } else {
  //         Fluttertoast.showToast(msg: 'Error: ${e.message}');
  //       }
  //     } catch (e) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       Fluttertoast.showToast(msg: 'Error: $e');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child:

          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                Center(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3,
                    child: Image.asset("assets/img_3.png",),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height/9,),

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                                controller: emailcontroller,
                                autocorrect: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  // if (!RegExp(
                                  //     r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                                  //     .hasMatch(value)) {
                                  //   return 'Please enter a valid User Name';
                                  // }
                                  return null;
                                  // You can add more complex email validation here if needed
                                  return null;
                                },
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: sh_backbt,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 0.7),
                                    labelText: 'User Name',
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      color: sh_text,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: sh_linear_textfield),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: sh_linear_textfield),
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: passwordcontroller,
                                autocorrect: true,
                                obscureText: _obscureText,
                                textInputAction: TextInputAction.done,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password should have min 8 characters';
                                  }
                                  // You can add more complex password validation here if needed
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.normal,
                                    color: sh_text),
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Image.asset(
                                        _obscureText
                                            ? "assets/passwordIcon_hide.png"
                                            : "assets/passwordIcon_show.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(bottom: 0.7),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      color: sh_text,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: sh_linear_textfield),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: sh_linear_textfield),
                                    ))),
                            SizedBox(
                              height: 40,
                            ),
                            // Align(
                            //     alignment: Alignment.topRight,
                            //     child: InkWell(
                            //         onTap: () {
                            //           String email = emailcontroller.text;
                            //           Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     ForgetPassword(email)),
                            //           );
                            //         },
                            //         child: Text(
                            //           "Forgot Password?",
                            //           style: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             fontSize: 16.sp,
                            //             fontWeight: FontWeight.w200,
                            //           ),
                            //         ))),

                            InkWell(
                              onTap: ()
                                  {
                                //   await NotificationService.initialize();
                                //   print(DEVICE_TOKEN +
                                //       " NOTIFICATION DEVICE TOKEN FOR LOGIN USER");
                                // if (_formKey.currentState!.validate()) {
                                //   setState(() {
                                //     print("IIIIIIIIIIIIIIIiii");
                                //     _isLoading = true;
                                //   });
                                //   // Navigator.push(
                                //   //   context,
                                //   //   MaterialPageRoute(
                                //   //       builder: (context) =>
                                //   //           ImageUploadScreen()),
                                //   // );
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                // }
                                    String _username = "vikas@gmail.com";
                                    String _password = "12345678";

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      // Check if entered username and password match the static ones
                                      if (emailcontroller.text == _username &&
                                          passwordcontroller.text == _password) {
                                        Fluttertoast.showToast(msg: 'Login Success');
                                        // Credentials are correct, proceed to login
                                        // Here you can navigate to the next screen or perform any other action
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ImageUploadScreen()),
                                        );
                                      } else {
                                        Fluttertoast.showToast(msg: 'User Not Registered');
                                        // Incorrect credentials, show error message or handle as needed
                                        print("Incorrect username or password");
                                      }

                                      // Reset form fields and loading state
                                      setState(() {
                                        _isLoading = false;
                                        emailcontroller.clear();
                                        passwordcontroller.clear();
                                      });
                                    }

                                    // _formKey.currentState!.validate();
                                    // FirebaseAuth.instance.signInWithEmailAndPassword(email: _username, password: _password).then((value) {
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadScreen(),));
                                    // });


                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 2),
                                      width: width,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Center(
                                          child:
                                          // _isLoading == true
                                          //     ? Container(
                                          //   height: 10,
                                          //   width: 10,
                                          //   child: CircularProgressIndicator(
                                          //     color: Colors.white,
                                          //     strokeWidth: 5,
                                          //
                                          //   ),
                                          // )
                                          //     :
                                          Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                  ),
                ),




              ]),


        ),
      ),
    );
  }


  }


