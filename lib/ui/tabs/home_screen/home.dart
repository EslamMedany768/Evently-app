import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evantly_app/model/event.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/tabs/home_screen/tabBar_widget.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../l10n/app_localizations.dart';
import '../widget/event_card_widget.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<FirebaseProvider>(context);
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvent(userProvider.currentUser?.id??"69");
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.11,
        backgroundColor: AppColors.blue,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome_back,
                      style: AppStyle.w40014white,
                    ),
                    Text(
                      userProvider.currentUser?.name??"",
                      style: AppStyle.bold24white,
                    )
                  ],
                ),
                Row(
                  children: [
                    ImageIcon(
                      AssetImage("assets/images/Sun.png"),
                      color: AppColors.primary_light,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.primary_light,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "EN",
                        style: AppStyle.bold14blue,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                ImageIcon(
                  AssetImage("assets/images/location.png"),
                  color: AppColors.primary_light,
                  size: 24,
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Text(
                  "Cairo , Egypt",
                  style: AppStyle.medium14white,
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.11,
            decoration: BoxDecoration(
                color: AppColors.blue,
                border: Border.all(color: AppColors.blue),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                DefaultTabController(
                    initialIndex: eventListProvider.selectedIndex,
                    length: eventListProvider.eventTitle.length,
                    child: TabBar(
                        onTap: (value) {
                          eventListProvider.changeSelectedIndex(value,userProvider.currentUser!.id);
                          setState(() {});
                        },
                        labelPadding: EdgeInsets.only(left: 10),
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        tabs: eventListProvider.eventTitle.map(
                          (text) {
                            return TabBarWidget(
                              title: text,
                              isSelected: eventListProvider.selectedIndex ==
                                      eventListProvider.eventTitle.indexOf(text)
                                  ? true
                                  : false,
                            );
                          },
                        ).toList()))
              ],
            ),
          ),
          eventListProvider.filterList.isEmpty
              ? Center(child: Text("no items added"))
              : Expanded(
                  child: ListView.builder(
                    itemCount: eventListProvider.filterList.length,
                    itemBuilder: (context, index) {
                      return EventCardWidget(
                        event: eventListProvider.filterList[index],
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
