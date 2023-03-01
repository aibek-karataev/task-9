import 'package:flutter/widgets.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/model/weather_hourly_data.dart';
import 'package:weather/utils/custom_colors.dart';

class ComforLevel extends StatelessWidget {
  final WeatherDataHourly weahterDataHourly;
  ComforLevel({super.key, required this.weahterDataHourly});

  final cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 2, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 160,
          child: Column(children: [
            Center(
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: weahterDataHourly
                    .hourly[cardIndex.value].humidity!
                    .toDouble(),
                appearance: CircularSliderAppearance(
                  infoProperties: InfoProperties(
                    bottomLabelText: "Humadity",
                    bottomLabelStyle: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: "Roboto"),
                  ),
                  animationEnabled: true,
                  size: 140,
                  customWidths: CustomSliderWidths(
                    handlerSize: 0,
                    trackWidth: 12,
                    progressBarWidth: 12,
                  ),
                  customColors: CustomSliderColors(
                    hideShadow: true,
                    trackColor: CustomColors.firstGradientColor.withAlpha(100),
                    progressBarColors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Feels like ",
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text:
                          "${weahterDataHourly.hourly[cardIndex.value].feelsLike}",
                      style: const TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 15,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "UV Index ",
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "${weahterDataHourly.hourly[cardIndex.value].uvi}",
                      style: const TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                )
              ],
            )
          ]),
        ),
      ],
    );
  }
}
