import 'package:flutter/material.dart';


class MyTextField extends StatefulWidget {

  final String hintText;
  final bool obscure;
  final TextEditingController contoller;
  final FocusNode?focusNode;

  const MyTextField({super.key,
    required this.hintText,
    required this.obscure,
    required this.contoller,
     this.focusNode
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: widget.obscure,
        controller: widget.contoller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            )
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
               color: Theme.of(context).colorScheme.primary,

            ),
         ),

          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText:widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary
          ),


        )

      ),
    );
  }
}
