import 'package:flutter/material.dart';


class MyButton extends StatefulWidget {

  final String text;
  final void Function()? onTap;

  const MyButton({super.key,
  required this.text,
    required this.onTap,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: 310,
          height: 55,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),

          child: Center(child:Text(widget.text)),
        ),
      ),
    );
  }
}
