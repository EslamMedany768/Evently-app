import 'package:evantly_app/auth/create_account.dart';
import 'package:evantly_app/firebase_utils.dart';
import 'package:evantly_app/model/my_user.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/home/home_screen.dart';
import 'package:evantly_app/ui/tabs/widget/customButton.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:evantly_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController(text: "fdsfds@gmail.com");
  var passwordController = TextEditingController(text: "123456789");
  var key = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Future<UserCredential?> loginWithGoogle() async {
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          DialogUtils.show(context: context, message: "error");
          return null;
        }

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        MyUser user = MyUser(
            name: userCredential.user!.displayName!,
            id: userCredential.user!.uid,
            email: userCredential.user!.email!);
        await FirebaseUtils.addUserToFireStore(user);
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        DialogUtils.show(
            context: context,
            title: "success",
            message: "user created successfully",
            posActName: "ok",
            posActButton: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });

        return userCredential;
      } catch (e) {
        print(e.toString());
        DialogUtils.show(
            context: context,
            title: "error",
            message: e.toString(),
            posActName: "ok",
            posActButton: () {
              Navigator.pop(context);
            });
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            Container(
                height: height * 0.30,
                child: Image.asset("assets/images/EventlyLogo.png")),
            Form(
              key: key,
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blue)),
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: AppStyle.bold16blue,
                          )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Custombutton(
                      onButtonClick: () {
                        login();
                      },
                      text: "Login",
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
                  "Don’t Have Account ?",
                  style: AppStyle.bold16blue.copyWith(color: Colors.black),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 5)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CreateAccount.routeName);
                    },
                    child: Text(
                      "Create Account",
                      style: AppStyle.bold16blue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.blue),
                    ))
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.blue,
                    thickness: 2,
                    indent: 45,
                    endIndent: 30,
                  ),
                ),
                Text(
                  "Or",
                  style: AppStyle.bold20blue,
                ),
                Expanded(
                    child: Divider(
                  color: AppColors.blue,
                  thickness: 2,
                  indent: 30,
                  endIndent: 45,
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Custombutton(
                  onButtonClick: () {
                    loginWithGoogle();
                  },
                  center: true,
                  borderColor: AppColors.blue,
                  imagePathPrefix: "assets/images/googleIcon.png",
                  text: "Login With Google",
                  bgColor: Colors.white,
                  Textstyle: AppStyle.bold20blue),
            )
          ],
        ),
      ),
    );

  }

  void login() async {
    if (key.currentState?.validate() == true) {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Loading..."),
                ],
              ),
            );
          },
        );
        print("BEFORE FIREBASE");
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print("after FIREBASE");
        MyUser? user =
            await FirebaseUtils.readUserFromFireStore(credential.user!.uid);
        if (user == null) {
          print("user is equal null");
          return;

        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);


        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        print("login successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }catch(e){
        print("error____________$e");
      }
    }
  }
}
