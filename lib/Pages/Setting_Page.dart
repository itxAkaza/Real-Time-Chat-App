import 'package:chatapp/themes/Theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key});

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {



  @override
  Widget build(BuildContext context) {
    final themeprovider=Provider.of<ThemeProvider>(context);

    backgroundColor: Theme.of(context).colorScheme.background;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,

      ),

      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)

        ),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text("Dark Mode"),

            CupertinoSwitch(
                value: themeprovider.isDarkMode,
                onChanged: (value)=>themeprovider.toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
