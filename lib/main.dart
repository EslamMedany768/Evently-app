import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evantly_app/auth/create_account.dart';
import 'package:evantly_app/auth/login.dart';
import 'package:evantly_app/providers/App_theme_provider.dart';
import 'package:evantly_app/providers/MainProvider.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/home/addEventScreen/add_event.dart';
import 'package:evantly_app/ui/home/addEventScreen/event_details.dart';
import 'package:evantly_app/ui/tabs/widget/edit_event.dart';
import 'package:evantly_app/ui/home/home_screen.dart';
import 'package:evantly_app/ui/tabs/profile_screen/profile_screen.dart';
import 'package:evantly_app/utils/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'package:evantly_app/providers/App_language_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainProvider(),),
      ChangeNotifierProvider(create: (context) => UserProvider(),),
      ChangeNotifierProvider(
        create: (context) => FirebaseProvider(),
      ),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ChangeNotifierProvider(
        create: (context) => AppLanguageProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var Applanguage = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      locale: Locale(Applanguage.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: Login.routeName,
      routes: {
        AddEventScreen.routeName: (context) => AddEventScreen(),
        EventDetails.routeName: (context) => EventDetails(),
        EditEvent.routeName: (context) => EditEvent(),
        CreateAccount.routeName: (context) => CreateAccount(),
        Login.routeName: (context) => Login(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
