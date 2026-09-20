import 'package:evantly_app/model/event.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/ui/tabs/widget/customButton.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/ui/tabs/widget/edit_event.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../providers/user_provider.dart';
import 'custom_tab_widget.dart';
import 'date_or_clock.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = "EventDetails";

  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetails();
}

class _EventDetails extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Event;
    var userProvider = Provider.of<UserProvider>(context);

    var eventListProvider = Provider.of<FirebaseProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blue),
        title: Text(
          "Event Details",
          style: TextStyle(color: AppColors.blue),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditEvent.routeName,arguments: args);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async{
                ///todo: deleteEvent},

               await  FirebaseUtils.deleteEventInFireStore(userProvider.currentUser!.id, args);
               eventListProvider.getAllEvent(userProvider.currentUser!.id);
               Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              height: height * 0.23,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Image.asset(
                args.image,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    args.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  calenderOrLocationWidget(
                      args, width, Icons.calendar_month, "", true),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  calenderOrLocationWidget(
                      args, width, Icons.my_location, args.address, false),
                  SizedBox(
                    height: height * 0.22,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    args.description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calenderOrLocationWidget(
      args, width, icon, String? text, bool isCalender) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Icon(
                icon,
                color: Colors.white,
              )),
          SizedBox(
            width: width * 0.02,
          ),
          isCalender
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat("d MMMM yyyy").format(args.history)),
                    Text(args.Time)
                  ],
                )
              : Text(text!)
        ],
      ),
    );
  }
}
