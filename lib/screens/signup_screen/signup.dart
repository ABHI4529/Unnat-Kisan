import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unnatkisan/components/textbox.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:unnatkisan/model/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/autosuggest.dart';
import '../../utils/utilslists.dart';
import '../home_screen/home.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key, this.phoneNumber});
  String? phoneNumber;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> filtercities = [];
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _phoneNumber = TextEditingController();
  String _city = "";
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber == null) {
      null;
    } else {
      setState(() {
        _phoneNumber.text = widget.phoneNumber!;
      });
    }
    setState(() {
      filtercities = cities;
    });
  }

  Future saveclient() async {
    final client = Client(
        fullName: _nameController.text,
        mailId: _mailController.text,
        age: int.parse(_ageController.text),
        city: _city,
        phoneNumber: _phoneNumber.text);
    final dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/client.json");
    file.writeAsStringSync(jsonEncode(client));
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
                  controller: _nameController,
                  suffix: const Icon(Icons.account_circle),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ATextField(
                  header: "Email ID",
                  controller: _mailController,
                  suffix: const Icon(Icons.email),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ATextField(
                  header: "Phone Number",
                  textInputType: TextInputType.phone,
                  controller: _phoneNumber,
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
                    onSelected: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
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
                    controller: _ageController,
                    suffix: const Icon(Icons.date_range),
                    textInputType: TextInputType.number,
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
          onPressed: () async {
            saveclient().then((value) async {
              final preferences = await SharedPreferences.getInstance();
              await preferences.setBool("isLoggedIn", true).then((value) =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home())));
            });
          },
          child: const Text("Save"),
        ),
      ),
    );
  }
}
