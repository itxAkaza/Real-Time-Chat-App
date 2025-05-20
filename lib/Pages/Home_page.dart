import 'package:chatapp/Pages/Chat_Page.dart';
import 'package:chatapp/Pages/LoginPage.dart';
import 'package:chatapp/Util.dart';
import 'package:chatapp/components/my_Drawer.dart';
import 'package:chatapp/services/auth/AuthServices.dart';
import 'package:chatapp/services/chat/chatServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/User_Tile.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final chatservices=Chatservices();
  final auth=Authservices();



  @override
  Widget build(BuildContext context) {
    backgroundColor: Theme.of(context).colorScheme.background;

    return Scaffold(
      appBar:  AppBar(
        title: Text("Home Page"),
        centerTitle: true,

      ),
        drawer:MyDrawer(),
      body: _builedUserList(),


    );


  }


  Widget _builedUserList(){
    return StreamBuilder(
        stream: chatservices.getUserStream(),

        builder: ((context,snapshot){
          //error
          if(snapshot.hasError)
            {
              return const Text("Error");
            }

          if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }

          //list tile
          return ListView(
            children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList()
          );
        })
    );



  }

  // build individual liast tile for user

  Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
    //display all user except current

    if(userData["email"]!=auth.getCurrentUser()!.email)
      {
        return UserTile(
          text: userData["email"],
          onTap: (){
            //tab on user to go to chat
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPageScreen(
              reciversemail: userData["email"],
              reciverid: userData["uid"],
            )));
          },
        );
      }
    else
      {
        return Container();
      }

  }


}
