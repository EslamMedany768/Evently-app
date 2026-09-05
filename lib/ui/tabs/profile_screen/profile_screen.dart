import 'package:evantly_app/providers/App_language_provider.dart';
import 'package:evantly_app/providers/App_theme_provider.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../auth/login.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/firebase_provider.dart';
import '../widget/customButton.dart';
import 'ThemeModelSheet.dart';
import 'languageModelSheet.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "ProfileScreen";

  @override
  State<ProfileScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var Applanguage = Provider.of<AppLanguageProvider>(context);
    var AppTheme = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var userProvider = Provider.of<UserProvider>(context);

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65))),
        backgroundColor: AppColors.blue,
        toolbarHeight: height * 0.196,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/rootIconAppbar.png",
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Safwat",
                    style: AppStyle.bold24white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "johnsafwat.route@gmail.com",
                    style: AppStyle.medium14white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                openBottomSheet(BottomSheetCustom());
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff5669FF), width: 1.5),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Applanguage.appLanguage == "ar"
                          ? AppLocalizations.of(context)!.arabic
                          : AppLocalizations.of(context)!.english,
                      style: TextStyle(
                          color: Color(0xff5669FF),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff5669FF),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                openBottomSheet(BottomSheetCustomTheme());
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff5669FF), width: 1.5),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTheme.appTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: TextStyle(
                          color: Color(0xff5669FF),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff5669FF),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Custombutton(
              onButtonClick: () {
                Provider.of<FirebaseProvider>(context,listen: false).clearAll();
                userProvider.currentUser = null;
                Navigator.of(context).pushReplacementNamed(Login.routeName);

              },
              prefixIcon: Icons.logout,
              text: "Logout",
              prefixIconColor: Colors.white,
              bgColor: Colors.red,
              Textstyle: AppStyle.bold20white,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void openBottomSheet(Widget bottomSheet) {
    showModalBottomSheet(context: context, builder: (context) => bottomSheet);
  }
}
