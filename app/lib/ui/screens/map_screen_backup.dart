import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  final mapController = MapController();

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Please enable your location");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Permission denied forever");
    }

    Position position = await Geolocator.getCurrentPosition();

    if (mounted) {
      mapController.fitCamera(CameraFit.bounds(
          minZoom: 9,
          maxZoom: 19,
          bounds: LatLngBounds.fromPoints([
            LatLng(position.latitude, position.longitude),
            LatLng(position.latitude + 0.001, position.longitude + 0.001),
          ])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          child: FlutterMap(
        mapController: mapController,
        options: const MapOptions(
          initialCenter: LatLng(8.251829356400696, 77.52383164106446),
          initialZoom: 10,
          maxZoom: 19,
          minZoom: 3,
        ),
        children: [
          TileLayer(
            urlTemplate: 'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',
            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
            maxZoom: 20,
            tileProvider: CancellableNetworkTileProvider(),
          ),
        ],
      )),
    );
  }
}
