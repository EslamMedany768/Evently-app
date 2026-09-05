import 'package:evantly_app/ui/tabs/favorite_screen/fav_screen.dart';
import 'package:evantly_app/ui/tabs/home_screen/home.dart';
import 'package:evantly_app/ui/tabs/map_screen/map_screen.dart';
import 'package:evantly_app/ui/tabs/profile_screen/profile_screen.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'addEventScreen/add_event.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> Tabs = [Home(), MapScreen(), FavScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55),
            side: BorderSide(width: 6, color: AppColors.primary_light)),
        backgroundColor: AppColors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed(AddEventScreen.routeName);
        },
        child: Icon(
          Icons.add,
          size: 24,
          color: AppColors.primary_light,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primary_light,
          unselectedItemColor: AppColors.primary_light,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavItem(
                path: "assets/images/home.png",
                name: AppLocalizations.of(context)!.home),
            BottomNavItem(
                path: "assets/images/Vector.png",
                name: AppLocalizations.of(context)!.map),
            BottomNavItem(
                path: "assets/images/Union.png",
                name: AppLocalizations.of(context)!.love),
            BottomNavItem(
                path: "assets/images/profile.png",
                name: AppLocalizations.of(context)!.profile),
          ]),
      body: Tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem BottomNavItem(
      {required String path, required String name}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(path),
        ),
        label: name);
  }
}
