import 'package:chatapp/Pages/Home_page.dart';
import 'package:chatapp/Pages/Register_Page.dart';
import 'package:chatapp/components/my_Text_Field.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Util.dart';
import '../services/auth/AuthServices.dart';

class LoginpageScreen extends StatefulWidget {
  const LoginpageScreen({super.key});

  @override
  State<LoginpageScreen> createState() => _LoginpageScreenState();
}

class _LoginpageScreenState extends State<LoginpageScreen> {

  final emailcontoller=TextEditingController();
  final passwordcontoller=TextEditingController();



  // Login Method
  void Login(BuildContext context) async{

         final authsService=Authservices();

         try
        {
          UserCredential userCredential = await authsService.signinWithEmailPassword(emailcontoller.text.toString(), passwordcontoller.text.toString());
          Utils().toastMessegessuccess("Welcome ${userCredential.user?.email}!");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
        }

        catch (e) {
          Utils().toastMesseges(e.toString());

        }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            //logo
            Icon(Icons.message,
            size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50,),

            //welcome back messege
            Text("Welcome back, you've been missed ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,

            ),
            ),
            const SizedBox(height: 25,),


            //email text field
            MyTextField(hintText: "Email",obscure: false,contoller:  emailcontoller,),
            const SizedBox(height: 10,),
            MyTextField(hintText: "Password",obscure: true,contoller: passwordcontoller,),

            //login button
            const SizedBox(height: 30,),

            MyButton(text: "Login",
                onTap: (){
                    FocusScope.of(context).unfocus();
                  Login(context);
            }
            ),

            const SizedBox(height: 25,),

            // register now
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15),),

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPageScreen()));
                  },
                      child: Text("Register now",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15),)
                  ),
                ],
              ),
            )
            
          ],
        ),
      ),

    );
  }
}
