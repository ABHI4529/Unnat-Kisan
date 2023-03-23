import 'package:flutter/material.dart';
import 'package:unnatkisan/components/textbox.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;

import '../../components/autosuggest.dart';
import '../../utils/utilslists.dart';
import '../home_screen/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> filtercities = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      filtercities = cities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Get started with the best platform and get all your needs in one place",
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ATextField(
                  header: "Full Name",
                  suffix: const Icon(Icons.account_circle),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ATextField(
                  header: "Email ID",
                  suffix: const Icon(Icons.email),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ATextField(
                  header: "Phone Number",
                  suffix: const Icon(Icons.phone),
                  prefix: Container(
                    padding: const EdgeInsets.only(left: 7, bottom: 2),
                    child: const Text("+91"),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Autocomplete(
                    optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isNotEmpty) {
                        return filtercities = cities
                            .where((element) => element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      }
                      return filtercities = cities;
                    },
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return ATextField(
                        suffix: const Icon(Icons.location_on),
                        header: "City",
                        controller: textEditingController,
                        focusNode: focusNode,
                        onSubmit: (value) => onFieldSubmitted,
                      );
                    },
                  )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: ATextField(
                    suffix: const Icon(Icons.date_range),
                    header: "Age",
                  )),
                  Expanded(child: Container()),
                  Container(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: const Text("Save"),
        ),
      ),
    );
  }
}
