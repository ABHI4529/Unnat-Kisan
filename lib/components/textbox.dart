import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATextField extends StatefulWidget {
  ATextField(
      {super.key,
      this.header,
      this.suffix,
      this.prefix,
      this.controller,
      this.focusNode,
      this.textInputType,
      this.onSubmit,
      this.inputFormatter});
  String? header;
  TextEditingController? controller;
  Widget? suffix;
  Widget? prefix;
  List<TextInputFormatter>? inputFormatter;
  TextInputType? textInputType;
  FocusNode? focusNode;
  ValueChanged<String>? onSubmit;

  @override
  State<ATextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<ATextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmit,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
          suffixIcon: widget.suffix,
          suffixIconConstraints: BoxConstraints(minWidth: 50),
          prefix: widget.prefix,
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withAlpha(30),
          label: Text("${widget.header}")),
    );
  }
}
