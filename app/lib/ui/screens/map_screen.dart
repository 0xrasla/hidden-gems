import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setUserAgent(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36")
        ..loadHtmlString("""

       <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Leaflet Map with Click Zoom and Marker</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <style>
      #map {
        height: 100vh;
        width: 100%;
      }
      body {
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>

  <h2>Leaflet Map with Click Zoom and Marker</h2>

    <script>
      const map = L.map("map", {
        center: [0, 0],
        zoom: 2,
        zoomControl: false,
      }).setView([8.251829356400696, 77.52383164106446], 10);

      const googleHybrid = L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        
      );

      googleHybrid.addTo(map);

      let marker;

      map.on("click", function (e) {
        const targetZoom = 15;
        const duration = 2000; // 2 seconds for zoom animation

        if (marker) {
          map.removeLayer(marker);
        }

        map.flyTo(e.latlng, targetZoom, {
          duration: duration / 1000,
        });

        setTimeout(() => {
          marker = L.marker(e.latlng).addTo(map);
        }, duration);
      });
    </script>
  </body>
</html>


""");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
