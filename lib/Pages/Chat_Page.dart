import 'package:chatapp/components/my_Text_Field.dart';
import 'package:chatapp/services/auth/AuthServices.dart';
import 'package:chatapp/services/chat/chatServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPageScreen extends StatefulWidget {

  final String reciversemail;
  final String reciverid;





  const ChatPageScreen({super.key,
  required this.reciversemail,
    required this.reciverid
  });

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {

  final messegecontroller=TextEditingController();
  final Chatservices chatservices=Chatservices();
  final Authservices authservices=Authservices();

  FocusNode myFoucusNode=FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    myFoucusNode.addListener((){
      if(myFoucusNode.hasFocus)
        {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrolldown();
          });
        }

    });

    Future.delayed(const Duration(microseconds: 400), ()=>scrolldown());

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFoucusNode.dispose();
    messegecontroller.dispose();
  }

  final Scrollcontroler=ScrollController();

  void   scrolldown()
  {
    Scrollcontroler.animateTo(Scrollcontroler.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn
    );


  }





  void sendmessege()async {
    if(!messegecontroller.text.isEmpty)
      {
        await chatservices.sendMessege(
            widget.reciverid, messegecontroller.text.toString()
        );
        messegecontroller.clear();
      }

    scrolldown();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.reciversemail),

      ),

      body: Column(
        children: [
          //user messeges
          Expanded(
              child: _buildmessegeList(),
          ),


          //send messege
          _buildUserinput()

        ],
      ),
    );
  }

  //build messege list

 Widget _buildmessegeList(){
    String Senderid=authservices.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatservices.getMessege(widget.reciverid,Senderid ),
        builder: (context,snapshot)
        {
          //error
          if(snapshot.hasError)
            {
              return Text("Error");
            }

          //loading
          if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }

          //return listview

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Scrollcontroler.hasClients) {
              scrolldown();
            }
          });

          return ListView(
            controller: Scrollcontroler,
            children:snapshot.data!.docs.map((doc)=>_buildmessegeitem(doc)).toList()

          );

        }
    );

 }


 Widget _buildmessegeitem(DocumentSnapshot doc){
    Map<String,dynamic> data=doc.data() as Map<String,dynamic>;

    bool iscurrentuser=data["Senderid"]==authservices.getCurrentUser()!.uid;
    var alignment=iscurrentuser? Alignment.centerRight:Alignment.centerLeft;


    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        alignment: alignment,

        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iscurrentuser?Colors.green:Colors.grey.shade500,
              borderRadius: BorderRadius.circular(15)
            ),


            //only this is main thing
            child: Text(data["messege"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)
        ),
      ),
    );

 }

 Widget _buildUserinput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20,right: 10),
      child: Row(
        children: [
          Expanded(
          child:  MyTextField(
          hintText: "Type a messege",
          focusNode:myFoucusNode ,
          obscure: false,
          contoller: messegecontroller)
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),

            child: IconButton(
                onPressed: sendmessege,
                icon: const Icon(Icons.arrow_upward),
               color: Colors.white,
            ),
          )
        ],
      ),
    );
 }
}
