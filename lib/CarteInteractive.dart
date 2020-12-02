import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/service/GlobaleService.dart';

import 'metier/Evenement.dart';

class CarteInteractive extends StatefulWidget {
  @override
  _CarteInteractive createState() => _CarteInteractive();
}

class _CarteInteractive extends State<CarteInteractive> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Set<Marker> _markers = Set();
  LatLng positionInitial = LatLng(0.0, 0.0);
  List<Evenement> events;
  Marker mark;

  void setEventList() async {
    List<Evenement> res;
    res = GlobaleService.Eventcollection as List<Evenement>;
    setState(() {
      events = res;
      MarkersMiseAJour();
    });
  }

  void MarkersMiseAJour() {
    setState(() {
      int id = 0;
      for (Evenement e in events) {
        int markId = id;
        _markers.add(
          Marker(
              markerId: MarkerId(id.toString()),
              position: LatLng(((e.coordonneGeo[0] as double )+ 0.0), (e.coordonneGeo[1] as double)+0.0),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                MarkerToucher(markId);
              }),
        );
        id++;
      }
    });
  }
  void MarkerToucher(int id) {
    setState(() {
      mark = _markers.elementAt(id);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  double zoom = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {},
          ),
        ),
        body: Stack(
          children: [
            googleMap(context),
            _zoommoins(),
            _zoomplus(),
            BuildContainer(),
          ],
        ));
  }

  Widget BuildContainer(){
    return Align(
    alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: 10.0),
            Padding(padding: const EdgeInsets.all(8.0)
            child: _boxes(

            ))
          ],
        ),
      ),
    );
  }
  Widget googleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        initialCameraPosition:
            CameraPosition(target: positionInitial, zoom: 11),
        onMapCreated: (GoogleMapController contoller) {
          _controller.complete(contoller);
        },
        //marker
      ),
    );
  }

  Widget _zoommoins() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoom--;
            _moins(zoom);
          }),
    );
  }

  Widget _zoomplus() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoom++;
            _plus(zoom);
          }),
    );
  }

  Future<void> _moins(double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoom)));
  }

  Future<void> _plus(double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoom)));
  }
}
