import 'dart:ui';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:unnatkisan/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:unnatkisan/screens/home_screen/home.dart';
import 'package:unnatkisan/screens/signup_screen/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void openOTPDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Verify OTP",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    OTPTextField(
                      length: 4,
                      width: double.maxFinite,
                      fieldWidth: 50,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                          backgroundColor: Colors.grey.withOpacity(0.1)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancled"),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: FilledButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => const Color(0xff4C7845))),
                              child: const Text("Next"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  final _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/login_background.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.maxFinite,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffE0F3CC).withOpacity(0.53)),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(30),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xff4C7845),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Container(
                        height: 40,
                      ),
                      ATextField(
                        header: "Phone Number",
                        controller: _phoneNumber,
                        textInputType: TextInputType.phone,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        suffix: const Icon(Icons.phone),
                        prefix: Container(
                          padding: const EdgeInsets.only(left: 7, bottom: 2),
                          child: const Text("+91"),
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                      SizedBox(
                        width: 150,
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => const Color(0xff4C7845))),
                          onPressed: () {
                            if (_phoneNumber.text.isEmpty ||
                                _phoneNumber.text.length != 10) {
                              debugPrint("Invalid Number");
                            } else {
                              openOTPDialog();
                            }
                          },
                          child: const Center(
                              child: Text(
                            "Send OTP",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Text(
                            'Or Continue With',
                            style: TextStyle(
                              color: Color(0xff4C7845),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      Container(
                        height: 30,
                      ),
                      SizedBox(
                        width: 190,
                        height: 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => const Color(0xff4C7845))),
                          onPressed: () {},
                          child: const Center(
                              child: Text(
                            "Login With Google",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Don't have an account yet ? "),
                                Text(
                                  "Create One",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
