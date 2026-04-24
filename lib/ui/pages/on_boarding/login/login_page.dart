import 'package:expenso_474/domain/constants/app_routes.dart';
import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:expenso_474/ui/custom_widgets/app_rounded_btn.dart';
import 'package:expenso_474/ui/pages/on_boarding/bloc/user_event.dart';
import 'package:expenso_474/ui/pages/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isPassVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hi, Welcome back!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value) {
                    RegExp emailRegex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    );

                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: mInputFieldDecoration(
                    hintText: "Enter your email here..",
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: 11),
                StatefulBuilder(
                  builder: (context, ss) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: !isPassVisible,
                      controller: passController,
                      decoration: mInputFieldDecoration(
                        hintText: "Enter your password here..",
                        labelText: "Password",
                        isPassField: true,
                        isPassVisible: isPassVisible,
                        onTap: () {
                          isPassVisible = !isPassVisible;
                          ss(() {});
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 11),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: ${state.errorMsg}"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      Navigator.pushNamed(context, AppRoutes.DASHBOARD_ROUTE);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User authenticated successfully!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppRoundedBtn(
                      isLoading: isLoading,
                      title: isLoading ? "Authenticating user.." : "Login",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            UserLoginEvent(
                              email: emailController.text,
                              pass: passController.text,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 5),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.SIGN_UP_ROUTE);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                        children: [
                          TextSpan(
                            text: "Create now..",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
