import 'dart:math';

import 'package:evantly_app/model/event.dart';
import 'package:evantly_app/providers/MainProvider.dart';
import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MainProvider mainProvider;

  late FirebaseProvider fireBaseProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseProvider = Provider.of<FirebaseProvider>(context, listen: false);
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    loadLocation();
    getCircles();
  }

  getCircles() {
    mainProvider.circles = fireBaseProvider.eventList.map(
          (event) {
        if (event.lat == "" || event.long == "") {
          event.lat = "0";
          event.long = "0";
        }
        return Circle(
            circleId: CircleId(event.id),
            fillColor: AppColors.primary_dark,
            radius: 14,
            strokeColor: Colors.grey,
            strokeWidth: 10,
            center: LatLng(double.parse(event.lat), double.parse(event.long)));
      },
    ).toSet();
    print(mainProvider.circles.first.center);
  }

  loadLocation() async {
    await mainProvider.getLocation();
    mainProvider.cameraAnimateToNewLocation(LatLng(
        mainProvider.locationData.latitude,
        mainProvider.locationData.longitude));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    fireBaseProvider = Provider.of<FirebaseProvider>(context);
    mainProvider = Provider.of<MainProvider>(context);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: mainProvider.cameraPosition,
          circles: mainProvider.circles,
          myLocationEnabled: true,
          onMapCreated: (controller) {
            mainProvider.mapController = controller;
          },
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 9,
            child: Container(

              ///Height & width of list View
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.03,
              ).copyWith(left: size.width * 0.05),
              height: size.height * 0.12,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // physics: PageScrollPhysics(),
                itemCount: fireBaseProvider.eventList.length,
                itemBuilder: (context, index) {
                  return cardWidget(
                      size: size, event: fireBaseProvider.eventList[index]);
                },
              ),
            )),
      ],
    );
  }

  Widget cardWidget({required dynamic size, required Event event}) {
    return InkWell(
      onTap: () {
        String targetCircleId = "";
        Circle? targetCircle;
        for (var circle in mainProvider.circles) {
          if (event.id == circle.circleId.value) {
            targetCircle = circle;
          }
        }

        if (targetCircle?.center.latitude == 0&&targetCircle?.center.longitude == 0) {
          return;
        } else {
          getCircles();
          mainProvider.circles.add(Circle(
              circleId: CircleId(event.id),
              fillColor: AppColors.blue,
              radius: 14,
              strokeColor: Colors.blue.withOpacity(0.5),
              strokeWidth: 10,

              center:
              LatLng(double.parse(event.lat), double.parse(event.long))));
        }
        mainProvider.mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(
                double.parse(event.lat), double.parse(event.long),),zoom: 17)));
        print(mainProvider.circles.first);
        setState(() {});
      },
      child: Container(
          margin: EdgeInsets.only(right: 8),
          width: size.width * 0.84,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.primary_light,
              border: Border.all(color: AppColors.blue, width: 1.2),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: [
              Container(
                  width: size.width * 0.33,

                  /// image in container
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Image.asset(event.image)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      event.title,
                      style: AppStyle.bold14blue,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        Expanded(child: Text(
                        maxLines: 1,
                            overflow: TextOverflow.ellipsis,event.address))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
