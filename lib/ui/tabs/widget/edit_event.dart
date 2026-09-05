import 'package:evantly_app/model/event.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/ui/tabs/widget/customButton.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../providers/user_provider.dart';
import '../../home/addEventScreen/custom_tab_widget.dart';
import '../../home/addEventScreen/date_or_clock.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = "EditEvent";

  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late Event args;

  bool first = true;
  DateTime? dateTime;
  String? time;
  TimeOfDay? timeOfDay;
  late var titleController = TextEditingController(text: args.title);
  late var descriptionController =
      TextEditingController(text: args.description);
  String selectedImage = "";
  String selectedTilte = "";
  late int selectedIndex;
  List<String> eventTitle = [
    'Sport',
    "Birthday",
    'Meeting',
    "Gaming",
    "Workshop",
    "Book Club",
    "Exhibition",
    "Holiday",
    "Eating"
  ];
  List<String> imageList = [
    "assets/images/sport.png",
    "assets/images/bg_cardWidget.png",
    "assets/images/metting.png",
    "assets/images/gaming.png",
    "assets/images/workshop.png",
    "assets/images/Book Club.png",
    "assets/images/exhibition.png",
    "assets/images/holiday.png",
    "assets/images/eating.png"
  ];

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Event;
    if (first == true) {
      selectedIndex = imageList.indexOf(args.image);
      first = false;
    }

    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<FirebaseProvider>(context);
    selectedImage = imageList[selectedIndex];
    selectedTilte = eventTitle[selectedIndex];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blue),
        title: Text(
          "Edit Eevent",
          style: TextStyle(color: AppColors.blue),
        ),
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
                imageList[selectedIndex],
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: height * 0.050,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: eventTitle.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: CustomTabWidget(
                      isSelected: selectedIndex == index,
                      eventName: eventTitle[index],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Customtextfield(
                      controller: titleController,
                      borderColor: AppColors.grey,
                      cursorColor: AppColors.grey,
                      errorColor: Colors.red,
                      name: "Event Title",
                      prefixIcon: Icons.note_alt_outlined,
                      prefixColor: AppColors.grey,
                      HintColor: AppColors.grey),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Customtextfield(
                      controller: descriptionController,
                      borderColor: AppColors.grey,
                      cursorColor: AppColors.grey,
                      errorColor: Colors.red,
                      name: "Event Description",
                      maxLines: 4,
                      HintColor: AppColors.grey),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DateOrClock(
                      prefix: Icons.calendar_month,
                      onButtonClick: showCalendar,
                      text: "Event Date",
                      textOfButton: dateTime == null
                          ? DateFormat("d MMMM yyyy").format(args.history)
                          : "${dateTime!.day}/"
                              "${dateTime?.month}/${dateTime?.year}"),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DateOrClock(
                      prefix: Icons.access_time_outlined,
                      onButtonClick: showTime,
                      text: "Event Time",
                      textOfButton: time == null ? args.Time : "${time}"),
                  SizedBox(
                    height: height * 0.01,
                  ),

                  Custombutton(
                      onButtonClick: () async{
                        Event event = Event(
                          id: args.id,
                            isfav: args.isfav,
                            image: selectedImage,
                            eventName: selectedTilte,
                            title: titleController.text,
                            description: descriptionController.text,
                            Time: time??args.Time,
                            history: dateTime??args.history);
                       await FirebaseUtils.updateEventInFireStore(userProvider.currentUser!.id, event)
                            .then((valur) {
                          Fluttertoast.showToast(
                              msg: "successfully Updated",
                              fontSize: 20,
                              backgroundColor: AppColors.blue,
                              textColor: AppColors.primary_light,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                          eventListProvider
                              .getAllEvent(userProvider.currentUser!.id);
                          Navigator.of(context).pop();
                          print("done");
                        });
                      },
                      text: "update Event",
                      bgColor: AppColors.blue,
                      center: true,
                      Textstyle: AppStyle.bold20white),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showCalendar() async {
    dateTime = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    setState(() {});
  }

  showTime() async {
    timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    time = timeOfDay?.format(context);
    setState(() {});
  }
}
