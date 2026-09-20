import 'package:evantly_app/providers/MainProvider.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickEventLocationScreen extends StatefulWidget {
  static const String routeName = "pickEventLocationScreen";

  const PickEventLocationScreen({super.key});

  @override
  State<PickEventLocationScreen> createState() =>
      _PickEventLocationScreenState();
}

class _PickEventLocationScreenState extends State<PickEventLocationScreen> {
  LatLng? pickedLocation;
  late MainProvider mainProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLocation();
    });
  }

  loadLocation() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(90),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Loading...",
              style: AppStyle.bold20blue,
            ),
            Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
              ),
            )
          ],
        ),
      ),
    );
    await mainProvider.getLocation();
    if (!mounted) return;
    await mainProvider.cameraAnimateToNewLocation(LatLng(
        mainProvider.locationData.latitude,
        mainProvider.locationData.longitude));
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blue),
        centerTitle: true,
        title: Text(
          "Pick Location",
          style: AppStyle.bold20blue,
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(overlayColor: Colors.transparent),
              onPressed: () {
                if (pickedLocation == null) {
                  pickedLocation = LatLng(mainProvider.locationData.latitude,
                      mainProvider.locationData.longitude);
                }
                Navigator.of(context).pop(pickedLocation);
                print("when navigator.pop $pickedLocation");
              },
              child: Icon(
                Icons.check,
                color: AppColors.blue,
                size: 28,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GoogleMap(
            initialCameraPosition: mainProvider.cameraPosition,
            onTap: (location) {
              pickedLocation = LatLng(location.latitude, location.longitude);
              print(pickedLocation);
              mainProvider.cameraAnimateToNewLocation(
                  LatLng(location.latitude, location.longitude));
            },
            onMapCreated: (controller) {
              mainProvider.mapController = controller;
            },
            markers: mainProvider.marker,
          )),
          Container(
            color: AppColors.blue,
            height: size.height * 0.07,
            child: Center(
                child: Text(
              "Tap on Location To Select",
              style: AppStyle.bold20white,
            )),
          )
        ],
      ),
    );
  }
}
