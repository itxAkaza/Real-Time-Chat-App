import 'package:chatapp/Pages/LoginPage.dart';
import 'package:chatapp/Util.dart';
import 'package:flutter/material.dart';

import '../components/my_Text_Field.dart';
import '../components/my_button.dart';
import '../services/auth/AuthServices.dart';


class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {


  final emailcontoller=TextEditingController();
  final passwordcontoller=TextEditingController();
  final confirmpasswordcontoller=TextEditingController();




  // Login Method
  void Signup(){


    final auth=Authservices();
    if(passwordcontoller.text.toString()==confirmpasswordcontoller.text.toString())
      {
        try
            {

              auth.SignupWithEmailPassword(
                  emailcontoller.text.toString(),
                  passwordcontoller.text.toString()
              );

              Utils().toastMessegessuccess("User created Succeffuly");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginpageScreen()));

            }
        catch (e)
           {

             Utils().toastMesseges(e.toString());

            }
      }
    else
      {
        Utils().toastMesseges("Password and Confirm password is not same!!!");
        return;

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
            Text("Let's create an acoount for you ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,

              ),
            ),
            const SizedBox(height: 25,),


            //email text field
            MyTextField(hintText: "Email",obscure: false,contoller:  emailcontoller,),
            const SizedBox(height: 10,),
            //password field
            MyTextField(hintText: "Password",obscure: true,contoller: passwordcontoller,),
            const SizedBox(height: 10,),
            //confim password
            MyTextField(hintText: " Confirm Password",obscure: true,contoller: confirmpasswordcontoller,),

            //login button
            const SizedBox(height: 30,),

            MyButton(text: "Sign Up",
              onTap:(){
                FocusScope.of(context).unfocus();
                Signup;
              }


            ),

            const SizedBox(height: 25,),

            // register now
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15),),

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginpageScreen()));
                  },
                      child: Text("Login now",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15),)
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
