import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/global_controller.dart';
import '../utils/custom_colors.dart';
import 'package:weather/model/weather_hourly_data.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weahterDataHourly;
  CurrentWeatherWidget({super.key, required this.weahterDataHourly});

  final GlobalController controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(children: [
        tempeatureAreaWidget(controller.currentIndex),
        const SizedBox(
          height: 20,
        ),
        currentWeatherMore(controller.currentIndex),
      ]),
    );
  }

  Widget tempeatureAreaWidget(RxInt index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weahterDataHourly.hourly[index.value].weather![0].icon}.png",
          width: 80,
          height: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weahterDataHourly.hourly[index.value].temp}°",
                style: const TextStyle(
                  color: CustomColors.textColorBlack,
                  fontSize: 60,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text:
                    "${weahterDataHourly.hourly[index.value].weather![0].description}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget currentWeatherMore(RxInt index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 60,
              height: 20,
              child: Text(
                "${weahterDataHourly.hourly[index.value].windSpeed}km/h",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 60,
              height: 20,
              child: Text(
                "${weahterDataHourly.hourly[index.value].clouds}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 60,
              height: 20,
              child: Text(
                "${weahterDataHourly.hourly[index.value].humidity}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
