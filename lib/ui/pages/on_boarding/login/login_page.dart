import 'package:expenso_474/domain/constants/app_routes.dart';
import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:expenso_474/ui/custom_widgets/app_rounded_btn.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isPassVisible = false;

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
                "Hi, Welcome back!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              TextField(
                controller: emailController,
                decoration: mInputFieldDecoration(
                  hintText: "Enter your email here..",
                  labelText: "Email",
                ),
              ),
              SizedBox(height: 11),
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
                },
              ),
              SizedBox(height: 11),
              AppRoundedBtn(
                  title: "Login", onTap: (){}
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.SIGN_UP_ROUTE);
                  },
                  child: Text.rich(
                    TextSpan(text: "Don't have an account? ", style: TextStyle(
                    fontSize: 12,
                    color: Colors.black38
                  ), children: [
                    TextSpan(text: "Create now..", style: TextStyle(
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
