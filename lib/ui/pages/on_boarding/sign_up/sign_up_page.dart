import 'package:expenso_474/data/models/user_model.dart';
import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:expenso_474/ui/pages/on_boarding/bloc/user_event.dart';
import 'package:expenso_474/ui/pages/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/app_rounded_btn.dart';
import '../bloc/user_bloc.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isPassVisible = false;
  bool isConfirmPassVisible = false;

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
                  "Hi, Welcome to Expenso!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: mInputFieldDecoration(
                    hintText: "Enter your name here..",
                    labelText: "Name",
                  ),
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
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Mobile no";
                    } else if (value.length != 10) {
                      return "Please enter a valid Mobile no";
                    } else {
                      return null;
                    }
                  },
                  controller: mobNoController,
                  decoration: mInputFieldDecoration(
                    hintText: "Enter your Mobile no here..",
                    labelText: "Mobile no",
                  ),
                ),
                SizedBox(height: 11),
                StatefulBuilder(
                  builder: (context, ss) {
                    return TextFormField(
                      validator: (value) {
                        RegExp passRegex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        );

                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (!passRegex.hasMatch(value)) {
                          return "Password must be 8 chars long with\nat-least 1 uppercase,\n1 lowercase,\n1 number\nand 1 special character";
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
                StatefulBuilder(
                  builder: (context, ss) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password again";
                        } else if (value != passController.text) {
                          return "Password doesn't match";
                        } else {
                          return null;
                        }
                      },
                      controller: confirmPassController,
                      obscureText: !isConfirmPassVisible,
                      decoration: mInputFieldDecoration(
                        hintText: "Re-enter your password..",
                        labelText: "Confirm Password",
                        isPassField: true,
                        isPassVisible: isConfirmPassVisible,
                        onTap: () {
                          isConfirmPassVisible = !isConfirmPassVisible;
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
                        SnackBar(content: Text("Error: ${state.errorMsg}"), backgroundColor: Colors.red,),
                      );
                    }

                    if(state is UserSuccessState){
                      isLoading = false;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User created successfully!!"), backgroundColor: Colors.green,),
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppRoundedBtn(
                      isLoading: isLoading,
                      title: isLoading ? "Creating account.." : "SignUp",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            UserSignUpEvent(
                              newUser: UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                mobNo: mobNoController.text,
                                budget: 0,
                                balance: 0,
                                pass: passController.text,
                                createAt: DateTime.now().millisecondsSinceEpoch,
                              ),
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
                      Navigator.pop(context);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                        children: [
                          TextSpan(
                            text: "Login now..",
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
