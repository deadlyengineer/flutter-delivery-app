import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:return_me/global.dart';

class MapDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialLocation,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      markers: (markers != null) ? (Set<Marker>.from(markers)) : null,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(pickUpLat, pickUpLng),
              zoom: 17.0,
            ),
          ),
        );
        print("$pickUpLat, $pickUpLng, $dropOffLat, $dropOffLng");
        if (pickUpLat != null &&
            pickUpLng != null &&
            dropOffLat != null &&
            dropOffLng != null) {
          _moveCamera();
        }
      },
      polylines:
          (polylines != null) ? (Set<Polyline>.of(polylines.values)) : null,
    );
  }

  _moveCamera() {
    LatLng latLng_1 = LatLng(pickUpLat, pickUpLng);
    LatLng latLng_2 = LatLng(dropOffLat, dropOffLng);

    LatLngBounds bounds;
    if (latLng_1.latitude <= latLng_2.latitude)
      bounds = LatLngBounds(southwest: latLng_1, northeast: latLng_2);
    else
      bounds = LatLngBounds(southwest: latLng_2, northeast: latLng_1);

    double centerLat = (latLng_1.latitude + latLng_2.latitude) / 2.0;
    double centerLng = (latLng_1.longitude + latLng_2.longitude) / 2.0;
    LatLng centerBounds = LatLng(centerLat, centerLng);

    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: centerBounds,
          zoom: 15.0,
        ),
      ),
    );

    zoomToFit(mapController, bounds, centerBounds);
  }

  Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds,
      LatLng centerBounds) async {
    bool keepZoomingOut = true;

    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - 0.5;
        controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: centerBounds,
              zoom: zoomLevel,
            ),
          ),
        );
        break;
      } else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }
}
