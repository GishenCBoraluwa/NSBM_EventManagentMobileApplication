import 'package:flutter/material.dart';

class InputLargeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLength;
  const InputLargeTextField({
    Key? key,
    this.controller,
    required this.maxLength,
  }) : super(key: key);

  @override
  State<InputLargeTextField> createState() => _InputLargeTextFieldState();
}

class _InputLargeTextFieldState extends State<InputLargeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controller,
      maxLength: widget.maxLength,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        suffixText: '${widget.controller?.text.length}/${widget.maxLength}',
        suffixStyle: TextStyle(
          color: widget.controller?.text.length == widget.maxLength
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.outlineVariant,
        ),
        border: const OutlineInputBorder(),
        counterText: '',
        hintText: 'Give a short description about the event',
        labelText: "Description",
      ),
    );
  }
}