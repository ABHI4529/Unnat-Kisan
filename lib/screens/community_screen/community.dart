import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List data = [];

  final botFieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(10),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Help"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              children: data
                  .map((e) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(70)),
                          child: Text(e),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: botFieldText,
          decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 50),
              hintText: "Send Message",
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    data.add(botFieldText.text);
                  });
                },
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        ),
      ),
    );
  }
}
