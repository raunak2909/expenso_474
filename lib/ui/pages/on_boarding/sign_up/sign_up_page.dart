import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/app_rounded_btn.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isPassVisible = false;
  bool isConfirmPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi, Welcome to Expenso!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: nameController,
                decoration: mInputFieldDecoration(
                    hintText: "Enter your name here..",
                    labelText: "Name"),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: emailController,
                decoration: mInputFieldDecoration(
                    hintText: "Enter your email here..",
                    labelText: "Email"),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: mobNoController,
                decoration: mInputFieldDecoration(
                    hintText: "Enter your Mobile no here..",
                    labelText: "Mobile no"),
              ),
              SizedBox(
                height: 11,
              ),
              StatefulBuilder(
                builder: (context, ss) {
                  return TextField(
                    obscureText: !isPassVisible,
                    controller: passController,
                    decoration: mInputFieldDecoration(
                        hintText: "Enter your password here..",
                        labelText: "Password",
                      isPassField: true,
                      isPassVisible: isPassVisible,
                      onTap: (){
                          isPassVisible = !isPassVisible;
                          ss((){});
                      }
                    ),
                  );
                }
              ),
              SizedBox(
                height: 11,
              ),
              StatefulBuilder(
                builder: (context, ss) {
                  return TextField(
                    controller: confirmPassController,
                    obscureText: !isConfirmPassVisible,
                    decoration: mInputFieldDecoration(
                        hintText: "Re-enter your password..",
                        labelText: "Confirm Password",
                        isPassField: true,
                        isPassVisible: isConfirmPassVisible,
                        onTap: (){
                          isConfirmPassVisible = !isConfirmPassVisible;
                          ss((){});
                        }
                    ),
                  );
                }
              ),
              SizedBox(
                height: 11,
              ),
              AppRoundedBtn(
                  title: "SignUp", onTap: (){}
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text.rich(
                    TextSpan(text: "Already have an account? ", style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38
                    ), children: [
                      TextSpan(text: "Login now..", style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade200,
                      ),)
                    ]),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
