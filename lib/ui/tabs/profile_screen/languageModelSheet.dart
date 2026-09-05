import 'package:evantly_app/providers/App_language_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom({super.key});

  @override
  Widget build(BuildContext context) {
    var Applanguage = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Applanguage.changelanguage("en");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.english,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Applanguage.appLanguage == "en"
                    ? Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 35,
                      )
                    : SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          InkWell(
            onTap: () {
              Applanguage.changelanguage("ar");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.arabic,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Applanguage.appLanguage == "ar"
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
