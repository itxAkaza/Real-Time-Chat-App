import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key,
    required this.text,
    required this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),


        ),

        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            //icon
            Icon(Icons.person),

            const SizedBox(width: 15,),

            //user name
            Text(text),
          ],
        ),

      ),
    );
  }
}

