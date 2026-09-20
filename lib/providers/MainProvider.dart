import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MainProvider extends ChangeNotifier {
  late LocationData locationData;
  String permissionMessage = "";
   Set<Circle> circles={};
  Location location = Location();


  late GoogleMapController mapController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set<Marker> marker = {
    Marker(
        markerId: MarkerId("0"),
        position: LatLng(37.42796133580664, -122.085749655962))
  };

  getLocation() async {
    bool permissionGranted = await _getLocationPermission();
    bool serviceEnable = await _getLocationService();

    if (!permissionGranted) {
      permissionMessage = "Permission Is Denied";
      notifyListeners();
      return;
    }
    if (!serviceEnable) {
      permissionMessage = "Location Service Is Disabled";
      notifyListeners();
      return;
    }
    permissionMessage = "All good";
    locationData = await location.getLocation();
    print(locationData);
    permissionMessage =
        "Destination (${locationData.latitude},${locationData.longitude})";
    notifyListeners();
  }

  // getNewLocation() {
  //   location.changeSettings(
  //     accuracy: LocationAccuracy.high,
  //   );
  //   location.onLocationChanged.listen(
  //     (location) {
  //       marker = {
  //         Marker(
  //             markerId: MarkerId("0"),
  //             position: LatLng(location.latitude, location.longitude))
  //       };
  //       cameraAnimateToNewLocation(location);
  //     },
  //   );
  // }

  cameraAnimateToNewLocation(LatLng locationData) {
    cameraPosition = CameraPosition(
        target: locationData,
        zoom: 17);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    marker={
      Marker(
          markerId: MarkerId("0"),
          position: LatLng(locationData.latitude, locationData.longitude))
    };
    notifyListeners();
  }

  Future<bool> _getLocationPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }

  Future<bool> _getLocationService() async {
    bool serviceEnable = await location.serviceEnabled();
    if (!serviceEnable) {
      serviceEnable = await location.requestService();
    }
    return serviceEnable;
  }
}
