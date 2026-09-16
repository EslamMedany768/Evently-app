import 'package:evantly_app/providers/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MainProvider mainProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context);
    return Column(
        children: [
          Expanded(
              child:
                  GoogleMap(initialCameraPosition: mainProvider.cameraPosition))
        ],
      )
    ;
  }
}
