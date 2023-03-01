import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController = Get.put(
    GlobalController(),
    permanent: true,
  );

  @override
  void initState() {
    getAdress(
      globalController.getLattitude().value,
      globalController.getLongtitude().value,
    );

    super.initState();
  }

  getAdress(lit, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lit, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            city.isEmpty ? 'Your location' : city,
            style: const TextStyle(
              fontSize: 30.0,
              height: 1.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 21.0, right: 20.0, bottom: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        )
      ],
    );
  }
}
