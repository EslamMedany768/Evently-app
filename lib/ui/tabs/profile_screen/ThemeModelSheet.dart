import 'package:evantly_app/providers/App_language_provider.dart';
import 'package:evantly_app/providers/App_theme_provider.dart';
import 'package:evantly_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class BottomSheetCustomTheme extends StatelessWidget {
  const BottomSheetCustomTheme({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              themeProvider.ChangeTheme(ThemeMode.light);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),

                themeProvider.appTheme==ThemeMode.light
                    ? Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 35,
                      ):
                     SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          InkWell(
            onTap: () {
              themeProvider.ChangeTheme(ThemeMode.dark);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dark,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                themeProvider.appTheme==ThemeMode.dark
                    ? Icon(Icons.check, color: Colors.blue, size: 35)
                    : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
