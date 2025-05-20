import 'package:chatapp/Pages/Setting_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/LoginPage.dart';
import '../Util.dart';
import '../services/auth/AuthServices.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});



  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

   late String currentUserEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authser=Authservices();
    final user = authser.getCurrentUser();
    currentUserEmail = user?.email ?? 'No email found';


  }

  void logOut(){
    final auth=Authservices();

    try
    {
      auth.SignOut();
      Utils().toastMessegessuccess("User Logged Out");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginpageScreen()));
    }
    catch (e)
    {
      Utils().toastMesseges(e.toString());

    }

  }





  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

         Column(

           children: [


             DrawerHeader(

                 child: Column(

                   children: [
                     Center(
                       child: Icon(
                         Icons.message,
                         size: 50,
                         color: Theme.of(context).colorScheme.primary,

                       ),
                     ),
                     SizedBox(height: 10,),

                     Padding(
                       padding: const EdgeInsets.only(left: 20),
                       child: ListTile(
                         leading: Icon(Icons.person,
                         size: 40,
                           color: Theme.of(context).colorScheme.primary,

                         ),
                         title: Text("Welcome",style: TextStyle(fontSize: 19)),
                         subtitle:Text(currentUserEmail) ,


                       ),
                     ),

                   ],
                 )
             ),

             //logo

             //home list tile

             Padding(
               padding: const EdgeInsets.only(left: 25),
               child: ListTile(
                 title: Text("H O M E"),
                 leading:Icon(Icons.home,
                 color: Theme.of(context).colorScheme.primary,

                 ) ,
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
             ),

             //setting list tile

             Padding(
               padding: const EdgeInsets.only(left: 25),
               child: ListTile(
                 title: Text("S E T T I N G S"),
                 leading:Icon(Icons.settings,
                  color: Theme.of(context).colorScheme.primary
                 ) ,
                 onTap: (){
                   Navigator.pop(context);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPageScreen()));
                 },
               ),
             ),

           ],
         ),
          //logout list tile

          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading:Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.primary

              ) ,
              onTap: (){
                logOut();
              },
            ),
          )

        ],
      ),
    );
  }
}
