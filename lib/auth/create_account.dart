import 'package:evantly_app/auth/login.dart';
import 'package:evantly_app/ui/home/home_screen.dart';
import 'package:evantly_app/ui/tabs/widget/customButton.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase_utils.dart';
import '../model/my_user.dart';
import '../providers/user_provider.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = "createAccScreen";

  CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "eslam");
  var emailController = TextEditingController(text: "fdsfds@gmail.com");
  var passwordController = TextEditingController(text: "123456789");
  var rePasswordController = TextEditingController(text: "123456789");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.07,
        title: Text(
          "Register",
          style: AppStyle.bold20blue,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.blue),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: height * 0.221,
                child: Image.asset("assets/images/EventlyLogo.png")),
            SizedBox(
              height: height * 0.02,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Customtextfield(
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Enter your Name";

                          ///invalid
                        }
                        return null;

                        ///valid
                      },
                      name: "Name",
                      borderColor: AppColors.grey,
                      prefixColor: AppColors.grey,
                      HintColor: AppColors.grey,
                      errorColor: Colors.red,
                      prefixIcon: Icons.email,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Customtextfield(
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Enter your Email";

                          ///invalid
                        }
                        return null;

                        ///valid
                      },
                      name: "Email",
                      borderColor: AppColors.grey,
                      prefixColor: AppColors.grey,
                      HintColor: AppColors.grey,
                      errorColor: Colors.red,
                      prefixIcon: Icons.email,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Customtextfield(
                      controller: passwordController,
                      name: "Password",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Enter your password";

                          ///invalid
                        }
                        return null;
                      },
                      borderColor: AppColors.grey,
                      prefixColor: AppColors.grey,
                      HintColor: AppColors.grey,
                      errorColor: Colors.red,
                      prefixIcon: Icons.lock,
                      sufixIcon: Icons.visibility_off,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Customtextfield(
                      name: "Re Password",
                      controller: rePasswordController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Enter your password";

                          ///invalid
                        }
                        return null;
                      },
                      borderColor: AppColors.grey,
                      prefixColor: AppColors.grey,
                      HintColor: AppColors.grey,
                      errorColor: Colors.red,
                      prefixIcon: Icons.lock,
                      sufixIcon: Icons.visibility_off,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Custombutton(
                      onButtonClick: () {
                        Register();
                      },
                      text: "Create Account",
                      bgColor: AppColors.blue,
                      Textstyle: AppStyle.bold20white,
                      center: true,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account ?",
                  style: AppStyle.bold16blue.copyWith(color: Colors.black),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 5)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login",
                      style: AppStyle.bold20blue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.blue),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void Register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    padding: EdgeInsets.all(22),
                    color: AppColors.blue,
                  ),
                  Text("Loading..."),
                ],
              ),
            );
          },
        );
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        await FirebaseUtils.addUserToFireStore(MyUser(
            name: nameController.text,
            id: credential.user?.uid ?? "",
            email: emailController.text));
        MyUser? user =
            await FirebaseUtils.readUserFromFireStore(credential.user!.uid);
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        print("registerSuccessfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print("error============$e");
      }
    }
  }
}
