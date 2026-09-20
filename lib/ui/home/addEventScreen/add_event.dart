import 'package:evantly_app/model/event.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/ui/home/addEventScreen/pick_event_location.dart';
import 'package:evantly_app/ui/tabs/widget/customButton.dart';
import 'package:evantly_app/ui/tabs/widget/customTextField.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../providers/MainProvider.dart';
import '../../../providers/user_provider.dart';
import 'custom_tab_widget.dart';
import 'date_or_clock.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "addEventScreen";

  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String? address;
  LatLng? pickedLocation;
  int selectedIndex = 0;
  DateTime? dateTime;
  String? time;
  TimeOfDay? timeOfDay;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String selectedImage = "";
  String selectedTilte = "";
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
    var mainProvider = Provider.of<MainProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<FirebaseProvider>(context);
    selectedImage = imageList[selectedIndex];
    selectedTilte = eventTitle[selectedIndex];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // scrolledUnderElevation: 0,
        // elevation: 0,
        iconTheme: IconThemeData(color: AppColors.blue),
        title: Text(
          "Create Eevent",
          style: TextStyle(color: AppColors.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.24,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Image.asset(
                        imageList[selectedIndex],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
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
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
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
                                ? "Choose Date"
                                : "${dateTime!.day}/"
                                    "${dateTime?.month}/${dateTime?.year}"),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        DateOrClock(
                            prefix: Icons.access_time_outlined,
                            onButtonClick: showTime,
                            text: "Event Time",
                            textOfButton:
                                time == null ? "Choose Time" : "${time}"),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            side: BorderSide(color: AppColors.blue),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)))),
                        onPressed: () async {
                          pickedLocation = await Navigator.of(context)
                                  .pushNamed(PickEventLocationScreen.routeName)
                              as LatLng?;

                          try {
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    pickedLocation!.latitude,
                                    pickedLocation!.longitude);
                            address =
                                "${placemarks[0].subThoroughfare},${placemarks[0].locality},${placemarks[0].country}";
                          } catch (e) {
                            address = "";
                          }

                          print("$address");
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Icon(
                                size: 25,
                                Icons.my_location,
                                color: AppColors.primary_light,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                pickedLocation == null
                                    ? "Choose Event Location"
                                    : address ?? "",
                                style: AppStyle.bold16blue,
                              ),
                            ),
                            Icon(
                              size: 16,
                              Icons.arrow_forward_ios,
                              color: AppColors.blue,
                            ),
                            SizedBox(
                              width: 2,
                            )
                          ],
                        )),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            SizedBox(
              height: height * 0.001,
            ),
            Custombutton(
                onButtonClick: () {
                  try {
                    Event event = Event(
                        image: selectedImage,
                        eventName: selectedTilte,
                        title: titleController.text,
                        description: descriptionController.text,
                        Time: time!,
                        address: address ?? "",
                        lat: pickedLocation?.latitude.toString()??"",
                        long: pickedLocation?.longitude.toString()??"",
                        history: dateTime!);

                    FirebaseUtils.addEventToFireStore(
                            event, userProvider.currentUser!.id)
                        .then((valur) {
                      Fluttertoast.showToast(
                          msg: "successfully added",
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
                  } catch (e) {
                    // Fluttertoast.showToast(msg: "Field is empty");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(child: Text("Field is empty")),
                      backgroundColor: AppColors.blue,
                    ));
                  }
                },
                text: "Add Event",
                bgColor: AppColors.blue,
                center: true,
                Textstyle: AppStyle.bold20white),
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
