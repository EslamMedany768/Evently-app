import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/tabs/widget/edit_event.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/event.dart';
import '../../home/addEventScreen/event_details.dart';

class EventCardWidget extends StatefulWidget {
  Event event;

  EventCardWidget({super.key, required this.event});

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<FirebaseProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetails.routeName, arguments: widget.event);
      },
      child: Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        padding: EdgeInsets.all(8),
        height: height * 0.31,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.blue, width: 2),
            // color: Colors.red,
            image: DecorationImage(
                image: AssetImage(widget.event.image), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: AppColors.primary_light,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Text(
                      "${widget.event.history.day}",
                      style: AppStyle.bold20blue.copyWith(fontSize: 24),
                    ),
                    Text(
                      "${DateFormat("MMM").format(widget.event.history)}",
                      style: AppStyle.bold20blue.copyWith(fontSize: 24),
                    ),
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    color: AppColors.primary_light,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Expanded(
                          child: Text(maxLines: 1,
                            "${widget.event.title}",
                            style: AppStyle.bold14blue
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          eventListProvider.updateIsFavoriteEvent(
                              widget.event, userProvider.currentUser!.id);
                        },
                        icon: Image.asset(widget.event.isfav == true
                            ? "assets/images/selectedFavorite.png"
                            : "assets/images/favIcon.png"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
